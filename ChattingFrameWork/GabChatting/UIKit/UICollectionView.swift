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
    
    init(@ViewBuilder viewBuilderClosure: @escaping () -> ContentView,
         keyboardOption: Binding<KeyboardOption>,
         inputHeight: CGFloat) {
        self.viewBuilderClosure = viewBuilderClosure
        self._keyboardOption = keyboardOption
        self.inputHeight = inputHeight
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
    func controlOffsetWithKeyboard(_ uiView: UICollectionView, context: Context) {
        switch keyboardOption.state {
        case .willShow, .didShow:
            isConditionWithKeyboardShow(uiView, context: context)
        case .willHide, .didHide:
            isConditionWithKeyboardHide(uiView, context: context)
        case .none:
            print("아무 처리 안함")
            break
        }
    }
    
    private func isConditionWithKeyboardShow(_ uiView: UICollectionView, context: Context) {
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
        
        print("키보드 올라감")
        
        if contentHeight > viewHeight {
            print("리스트가 더 많다")
            
            let firstCondition: CGFloat = contentHeight - viewHeight
            print("상갑 logEvent \(#function) firstCondition: \(firstCondition)")
            
            if firstCondition <= offsetY {
                print("바닥 이네?")
                moveOffsetY = offsetY + (keyboardHeight - inputHeight)
            } else {
                print("바닥 아니네")
                moveOffsetY = offsetY + keyboardHeight - inputHeight
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
            moveOffsetY = viewHeight - contentHeight - keyboardHeight + inputHeight
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
            
            animtor.startAnimation(afterDelay: 0)
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
//        if contentHeight > viewHeight {
//            print("오잉")
//            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                let moveOffsetY: CGFloat = offsetY - (keyboardHeight - inputHeight)
//                print("상갑 logEvent \(#function) moveOffsetY: \(moveOffsetY)")
//                uiView.setContentOffset(CGPoint(x: 0, y: moveOffsetY), animated: true)
//            }
//        } else {
//
//        }
    }
}
