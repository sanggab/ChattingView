//
//  UICollectionView.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

struct ChattingCollectionView<ContentView: View>: UIViewRepresentable {
    
    @ViewBuilder let viewBuilderClosure: () -> ContentView
    
    init(@ViewBuilder viewBuilderClosure: @escaping () -> ContentView) {
        self.viewBuilderClosure = viewBuilderClosure
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView: UICollectionView = .init(frame: .zero,
                                                     collectionViewLayout: context.coordinator.createCompositionalLayout())
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "chatcell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemMint
        
        context.coordinator.setDataSource(view: collectionView)
        context.coordinator.setData()
        
        return collectionView
    }
    
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        print("상갑 logEvent \(#function)")
    }
    
    func makeCoordinator() -> ChattingCoordinator<ContentView> {
        return ChattingCoordinator(viewBuilderClosure: viewBuilderClosure)
    }
}
