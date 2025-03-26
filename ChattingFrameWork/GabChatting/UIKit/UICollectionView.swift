//
//  UICollectionView.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

struct ChattingCollectionView<ContentView: View>: UIViewRepresentable {
    
    @ViewBuilder let viewBuilderClosure: () -> ContentView
    
    @Binding public var blankHeight: CGFloat
    
    init(@ViewBuilder viewBuilderClosure: @escaping () -> ContentView,
         blankHeight: Binding<CGFloat>) {
        self.viewBuilderClosure = viewBuilderClosure
        self._blankHeight = blankHeight
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
        print("상갑 logEvent \(#function)")
        let offsetY: CGFloat = uiView.contentOffset.y
        print("상갑 logEvent \(#function) blankHeight: \(blankHeight)")
        print("상갑 logEvent \(#function) contentoffset: \(uiView.contentOffset)")
        print("상갑 logEvent \(#function) uiView.intrinsicContentSize: \(uiView.intrinsicContentSize)")
        print("상갑 logEvent \(#function) uiView.contentSize: \(uiView.contentSize)")
        let firstCondition = uiView.contentSize.height > blankHeight
        
        switch Int(blankHeight) {
        case 0:
            print("0이다")
        case 1...Int.max:
            print("양수")
        case Int.min..<0:
            print("음수")
            
        default:
            break
        }
        
        if blankHeight != .zero {
//            if blankHeight > offsetY {
//                
//            } else {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//                    uiView.setContentOffset(CGPoint(x: 0, y: offsetY + blankHeight), animated: true)
//                }
//            }
        }
    }
    
    func makeCoordinator() -> ChattingCoordinator<ContentView> {
        return ChattingCoordinator(viewBuilderClosure: viewBuilderClosure)
    }
}
