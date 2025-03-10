//
//  ListCollectionView.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

struct ListCollectionView: UIViewRepresentable {
    
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: context.coordinator.createLayout())
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "chatcell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemMint
        collectionView.delegate = context.coordinator
        collectionView.dataSource = context.coordinator
        
        return collectionView
    }
        
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        
    }
    
    func makeCoordinator() -> CollectionViewCoordinator {
        return .init()
    }
}
