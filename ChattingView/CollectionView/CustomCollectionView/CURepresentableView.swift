//
//  CURepresentableView.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

struct CURepresentableView<ContentView: View>: UIViewRepresentable {
    
    @ViewBuilder var viewBuilderClosure: () -> ContentView
    
    init(@ViewBuilder contentView: @escaping () -> ContentView) {
        self.viewBuilderClosure = contentView
    }
    
    func makeUIView(context: Context) -> UICollectionView {
        let collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: context.coordinator.createLayout())
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "chatcell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemMint
        collectionView.delegate = context.coordinator
        
//        collectionView.dataSource = context.coordinator
//        self.testCollectionView = collectionView
        context.coordinator.setDataSource(view: collectionView)
        context.coordinator.setData(chatModel: [.init(memNo: 135, chatType: .img, sendType: .receive)])
        return collectionView
    }
        
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        print("\(#function)")
//        self.testCollectionView = uiView
//        context.coordinator.setDataSource(view: uiView)
//        context.coordinator.setData(chatModel: [.init(memNo: 135, chatType: .img, sendType: .receive)])
        context.coordinator.reloadData()
        uiView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .bottom, animated: true)
    }
    
    func makeCoordinator() -> CUCollectionViewCoordinator<ContentView> {
        return CUCollectionViewCoordinator(contentView: viewBuilderClosure)
    }
}
