//
//  UICollectionView.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

struct ChattingCollectionView<ContentView: View>: UIViewRepresentable {
    
    @ViewBuilder let viewBuilderClosure: () -> ContentView
    
    let keyboardHeight: CGFloat
    let inputHeight: CGFloat
    
    init(@ViewBuilder viewBuilderClosure: @escaping () -> ContentView,
         keyboardHeight: CGFloat,
         inputHeight: CGFloat) {
        self.viewBuilderClosure = viewBuilderClosure
        self.keyboardHeight = keyboardHeight
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
        print("상갑 logEvent \(#function) uiView.frame: \(uiView.frame)")
        print("상갑 logEvent \(#function) keyboardHeight: \(keyboardHeight)")
        print("상갑 logEvent \(#function) inputHeight: \(inputHeight)")
        print("상갑 logEvent \(#function) contentoffset: \(uiView.contentOffset)")
        print("상갑 logEvent \(#function) uiView.contentSize: \(uiView.contentSize)")
        let viewHeight: CGFloat = uiView.frame.height
        let contentHeight: CGFloat = uiView.contentSize.height
        let offsetY: CGFloat = uiView.contentOffset.y
        
        if keyboardHeight > 0 {
            print("키보드 올라옴")
            if contentHeight > viewHeight {
                print("리스트가 더 많다")
                let moveOffsetY: CGFloat = offsetY + keyboardHeight - inputHeight
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    uiView.setContentOffset(CGPoint(x: 0, y: abs(moveOffsetY)), animated: true)
                }
            } else {
                print("리스트가 더 적다")
                let moveOffsetY: CGFloat = viewHeight - contentHeight - keyboardHeight + inputHeight
                print("상갑 logEvent \(#function) : \(moveOffsetY)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    uiView.setContentOffset(CGPoint(x: 0, y: abs(moveOffsetY)), animated: true)
                }
            }
        } else {
            print("키보드 내려감")
        }
        
//        if contentHeight > viewHeight {
//            print("리스트가 더 많다")
//        } else {
//            print("리스트가 더 적다")
//            if keyboardHeight > 0 {
//                print("키보드 올라옴")
//            } else {
//                print("키보드 내려감")
//            }
//        }
    }
    
    func makeCoordinator() -> ChattingCoordinator<ContentView> {
        return ChattingCoordinator(viewBuilderClosure: viewBuilderClosure)
    }
}
