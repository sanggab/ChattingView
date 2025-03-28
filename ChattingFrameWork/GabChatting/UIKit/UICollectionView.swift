//
//  UICollectionView.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

import ChattingUtils

enum ChattingState: Equatable {
    case onAppear
    case keyboardShow
    case keyboardHide
    case textInput
}

struct ChattingCollectionView<ContentView: View>: UIViewRepresentable {
    
    @ViewBuilder let viewBuilderClosure: () -> ContentView
    
    @State private var chattingState: ChattingState = .onAppear
    
    @Binding var keyboardOption: KeyboardOption
    let inputHeight: CGFloat
    let safeAreaInsetBottom: CGFloat
    
    init(@ViewBuilder viewBuilderClosure: @escaping () -> ContentView,
         keyboardOption: Binding<KeyboardOption>,
         inputHeight: CGFloat,
         safeAreaInsetBottom: CGFloat) {
        self.viewBuilderClosure = viewBuilderClosure
        self._keyboardOption = keyboardOption
        self.inputHeight = inputHeight
        self.safeAreaInsetBottom = safeAreaInsetBottom
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView: UICollectionView = .init(frame: .zero,
                                                     collectionViewLayout: context.coordinator.createCompositionalLayout())
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "chatcell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemMint
        collectionView.delegate = context.coordinator
        
        context.coordinator.setDataSource(view: collectionView)
        context.coordinator.setData()
        
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        self.controlOffsetWithKeyboard(uiView, context: context)
    }
    
    func makeCoordinator() -> ChattingCoordinator<ContentView> {
        return ChattingCoordinator(viewBuilderClosure: self.viewBuilderClosure)
    }
}

extension ChattingCollectionView {
    /// Keyboard의 상태 변화에 따른 UICollectionView contentOffset 조절하는 기능
    func controlOffsetWithKeyboard(_ uiView: UICollectionView, context: Context) {
        switch self.keyboardOption.state {
        case .willShow:
            self.isConditionWithKeyboardShow(uiView, context: context)
        case .willHide:
            self.isConditionWithKeyboardHide(uiView, context: context)
        case .didShow:
            print("didShow")
        case .didHide:
            print("didHide")
        case .none:
            print("아무 처리 안함")
            print("상갑 logEvent \(#function) frame: \(uiView.frame)")
            break
        }
    }
    /// Keyboard가 올라올 때 처리를 하는 method
    ///
    /// Keyboard가 올라올 때, UICollectionView의 contentOffset.y을 조절해줍니다
    ///
    /// - Note: UICollectionView의 contentOffset.y의 위치에 따라 애니메이션이 다를 수 있습니다.
    private func isConditionWithKeyboardShow(_ uiView: UICollectionView, context: Context) {
        let viewHeight: CGFloat = uiView.frame.height
        let contentHeight: CGFloat = uiView.contentSize.height
        let offsetY: CGFloat = uiView.contentOffset.y
        let keyboardHeight: CGFloat = self.keyboardOption.size.height
        var moveOffsetY: CGFloat = .zero
        
        // collectionView의 높이보다 item의 높이가 더 큰 경우
        if contentHeight > viewHeight {
            moveOffsetY = offsetY + (keyboardHeight - self.safeAreaInsetBottom)
        } else {
            // item의 높이가 collectionView을 채우지 못 한 경우
            moveOffsetY = abs(offsetY + (viewHeight - contentHeight - keyboardHeight + self.safeAreaInsetBottom))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + self.keyboardOption.duration) {
                uiView.setContentOffset(CGPoint(x: 0, y: moveOffsetY), animated: true)
                uiView.layoutIfNeeded()
            }
        }
        
        /// 키보드가 올라올 때, contentOffset.y의 값이 키보드의 높이만큼 안 떨어져 있을 경우에, 키보드가 올라올 경우, 예를 들어 현재 y값이 784인데 높이가 312인 키보드가 올라올 경우, 1096이 맨 아래의 좌표값인데 키보드 애니메이션 도중에 y의 값이1096까지 확장이 안 된 상태에서 1096으로 setContentOffset을 해버릴 경우, 도중에 스크롤이 멈추는 형상이 있어서 애니메이션을 다르게 가져갑니다.
        if moveOffsetY > contentHeight - viewHeight {
            /// 바닥하고 키보드 높이 만큼 안 떨어져 있으면 딜레이를 줘서 움직입니다.
            DispatchQueue.main.asyncAfter(deadline: .now() + self.keyboardOption.duration) {
                uiView.setContentOffset(CGPoint(x: 0, y: moveOffsetY), animated: true)
                uiView.layoutIfNeeded()
            }
        } else {
            /// 바닥에서 키보드 높이 만큼 떨어져 있으면 바로 실행
            self.executeAnimator(uiView, offsetY: moveOffsetY)
        }
        
        DispatchQueue.main.async {
            self.keyboardOption.state = .none
        }
    }
    
    /// Keyboard가 내려갈 때 처리를 하는 method
    ///
    /// Keyboard가 내려갈 때, UICollectionView의 contentOffset.y을 조절해줍니다
    private func isConditionWithKeyboardHide(_ uiView: UICollectionView, context: Context) {
        let viewHeight: CGFloat = uiView.frame.height
        let contentHeight: CGFloat = uiView.contentSize.height
        let offsetY: CGFloat = uiView.contentOffset.y
        let keyboardHeight: CGFloat = self.keyboardOption.size.height
        var moveOffsetY: CGFloat = .zero
        let intriHeight: CGFloat = viewHeight + keyboardHeight - self.safeAreaInsetBottom

        /// item의 실제 높이가 collectionView의 실제 높이보다 크면서, contentOffset.y의 값이 keyboard의 높이보다 크거나 같은 경우에, y의 값을 바꿔준다.
        if intriHeight < contentHeight && (keyboardHeight - self.safeAreaInsetBottom) <= offsetY {
            
            moveOffsetY = offsetY - (keyboardHeight - self.safeAreaInsetBottom)
            
            self.executeAnimator(uiView, offsetY: moveOffsetY)
        }
        
        DispatchQueue.main.async {
            self.keyboardOption.state = .none
        }
    }
    
    /// setContentOffset 애니메이션 기능
    private func executeSetContentOffset(_ uiView: UICollectionView, offset: CGFloat) {
        DispatchQueue.main.asyncAfter(deadline: .now() + self.keyboardOption.duration) {
            uiView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
            uiView.layoutIfNeeded()
        }
    }
    /// UIViewPropertyAnimator 기능
    private func executeAnimator(_ uiView: UICollectionView, offsetY: CGFloat) {
        let curve = UIView.AnimationCurve(rawValue: self.keyboardOption.curve)!
        let animtor = UIViewPropertyAnimator(duration: self.keyboardOption.duration, curve: curve)
        
        animtor.addAnimations {
            uiView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: false)
            
            uiView.layoutIfNeeded()
        }
        
        animtor.startAnimation()
    }
}
