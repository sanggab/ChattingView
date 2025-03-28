//
//  UICollectionView.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

import ChattingUtils

struct ChattingCollectionView<ContentView: View>: UIViewRepresentable {
    
    @ViewBuilder let viewBuilderClosure: () -> ContentView
    
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
        return ChattingCoordinator(viewBuilderClosure: viewBuilderClosure)
    }
}

extension ChattingCollectionView {
    /// Keyboard의 상태 변화에 따른 UICollectionView contentOffset 조절하는 기능
    func controlOffsetWithKeyboard(_ uiView: UICollectionView, context: Context) {
        switch keyboardOption.state {
        case .willShow:
            isConditionWithKeyboardShow(uiView, context: context)
        case .willHide:
            isConditionWithKeyboardHide(uiView, context: context)
        case .didShow:
            print("didShow")
        case .didHide:
            print("didHide")
        case .none:
            print("아무 처리 안함")
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
        let keyboardHeight: CGFloat = keyboardOption.size.height
        var moveOffsetY: CGFloat = .zero
        
        print("상갑 logEvent \(#function) viewHeight: \(viewHeight)")
        print("상갑 logEvent \(#function) keyboardOption: \(keyboardOption)")
        print("상갑 logEvent \(#function) inputHeight: \(inputHeight)")
        print("상갑 logEvent \(#function) contentHeight: \(contentHeight)")
        print("상갑 logEvent \(#function) offsetY: \(offsetY)")
        
        if contentHeight > viewHeight {
            print("리스트가 더 많다")
            
            let firstCondition: CGFloat = contentHeight - viewHeight
            print("상갑 logEvent \(#function) firstCondition: \(firstCondition)")
            
            if firstCondition <= offsetY {
                print("바닥 이네?")
                moveOffsetY = offsetY + (keyboardHeight - safeAreaInsetBottom)
            } else {
                print("바닥 아니네")
                moveOffsetY = offsetY + keyboardHeight - safeAreaInsetBottom
//                    if firstCondition - offsetY < keyboardHeight {
//                        print("키보드 높이만큼 아니다")
////                        moveOffsetY = offsetY + (firstCondition - offsetY)
//                        moveOffsetY = offsetY + keyboardHeight - inputHeight
//                    } else {
//                        print("키보드 만큼이다")
//                        moveOffsetY = offsetY + keyboardHeight - inputHeight
//                    }
            }
            
        } else {
            print("리스트가 더 적다")
            moveOffsetY = abs(offsetY + (viewHeight - contentHeight - keyboardHeight + safeAreaInsetBottom))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + keyboardOption.duration) {
                uiView.setContentOffset(CGPoint(x: 0, y: moveOffsetY), animated: true)
                uiView.layoutIfNeeded()
            }
        }
        print("상갑 logEvent \(#function) moveOffsetY: \(moveOffsetY)")
        
        if moveOffsetY > contentHeight - viewHeight {
            DispatchQueue.main.asyncAfter(deadline: .now() + keyboardOption.duration) {
                uiView.setContentOffset(CGPoint(x: 0, y: moveOffsetY), animated: true)
                uiView.layoutIfNeeded()
            }
        } else {
            let curve = UIView.AnimationCurve(rawValue: keyboardOption.curve)!
            let animtor = UIViewPropertyAnimator(duration: keyboardOption.duration, curve: curve)
            
            animtor.addAnimations {
                uiView.setContentOffset(CGPoint(x: 0, y: moveOffsetY), animated: false)
                
                uiView.layoutIfNeeded()
            }
            
            animtor.startAnimation()
        }
        
        DispatchQueue.main.async {
            self.keyboardOption.state = .none
        }
    }
    
    private func isConditionWithKeyboardHide(_ uiView: UICollectionView, context: Context) {
        print("상갑 logEvent \(#function) uiView.frame: \(uiView.frame)")
        print("상갑 logEvent \(#function) keyboardOption: \(keyboardOption)")
        print("상갑 logEvent \(#function) inputHeight: \(inputHeight)")
        print("상갑 logEvent \(#function) contentoffset: \(uiView.contentOffset)")
        print("상갑 logEvent \(#function) uiView.contentSize: \(uiView.contentSize)")
        let viewHeight: CGFloat = uiView.frame.height
        let contentHeight: CGFloat = uiView.contentSize.height
        let offsetY: CGFloat = uiView.contentOffset.y
        let keyboardHeight: CGFloat = keyboardOption.size.height
        var moveOffsetY: CGFloat = .zero
        let intriHeight: CGFloat = contentHeight - viewHeight
        let realHeight: CGFloat = viewHeight + keyboardHeight - safeAreaInsetBottom
        print("상갑 logEvent \(#function) realHeight: \(realHeight)")
        print("상갑 logEvent \(#function) intriHeight: \(intriHeight)")
        
        if realHeight < contentHeight {
            print("리스트가 더 많아서 움직여야한다")
            
            let new = keyboardHeight - safeAreaInsetBottom
            if new > offsetY {
                print("상단 근처라서 안 움직여줘도됨")
            } else {
                moveOffsetY = offsetY - (keyboardHeight - safeAreaInsetBottom)
                
                let curve = UIView.AnimationCurve(rawValue: keyboardOption.curve)!
                let animtor = UIViewPropertyAnimator(duration: keyboardOption.duration, curve: curve)
                
                animtor.addAnimations {
                    uiView.setContentOffset(CGPoint(x: 0, y: moveOffsetY), animated: false)
                    
                    uiView.layoutIfNeeded()
                }
                
                animtor.startAnimation()
            }
            
        } else {
            print("리스트가 적어서 아무처리 x")
        }
        
        DispatchQueue.main.async {
            self.keyboardOption.state = .none
        }
    }
}
