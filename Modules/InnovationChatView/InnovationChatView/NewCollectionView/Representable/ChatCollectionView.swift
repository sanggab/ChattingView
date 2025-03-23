//
//  ChatCollectionView.swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

import Core
import ComposableArchitecture

struct ChatCollectionView<ContentView: View>: UIViewRepresentable {
    
    @ViewBuilder var viewBuilderClosure: () -> ContentView
    
    let store: StoreOf<ScrollViewStore>
    
    init(@ViewBuilder contentView: @escaping () -> ContentView,
         store: StoreOf<ScrollViewStore>) {
        self.viewBuilderClosure = contentView
        self.store = store
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: context.coordinator.createLayout())
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "chatcell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemMint
        collectionView.delegate = context.coordinator
        
        context.coordinator.setDataSource(view: collectionView)
        context.coordinator.setData(chatModel: [.init(memNo: 135, chatType: .img, sendType: .receive, msgNo: -99)])
        return collectionView
    }
        
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        print("상갑 logEvent \(#function)")
    }
    
    func makeCoordinator() -> ChatViewCoordinator<ContentView> {
        return ChatViewCoordinator(contentView: viewBuilderClosure, store: self.store)
    }
}
