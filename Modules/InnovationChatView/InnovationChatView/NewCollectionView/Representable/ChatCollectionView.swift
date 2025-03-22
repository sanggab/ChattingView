//
//  ChatCollectionView.swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

struct ChatCollectionView<ContentView: View>: UIViewRepresentable {
    
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
        
        context.coordinator.setDataSource(view: collectionView)
        context.coordinator.setData(chatModel: [.init(memNo: 135, chatType: .img, sendType: .receive, msgNo: -99)])
        return collectionView
    }
        
    func updateUIView(_ uiView: UICollectionView, context: Context) {
        print("상갑 logEvent \(#function)")
//        print("상갑 logEvent \(#function) chatState : \(viewModel(\.chatState))")
        
//        switch viewModel(\.chatState) {
//        case .none:
//            print("none")
//        case .reload:
//            context.coordinator.reloadData()
//            self.viewModel.action(.changeUpdateType(.none))
//        case .reconfigure:
//            context.coordinator.reconfigureItems()
//            self.viewModel.action(.changeUpdateType(.none))
//        case .scrollToBottom:
//            context.coordinator.reconfigureItems()
//            uiView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .bottom, animated: true)
//            self.viewModel.action(.changeUpdateType(.none))
//        case .isFoucsed:
//            uiView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .bottom, animated: false)
//            self.viewModel.action(.changeUpdateType(.none))
//        }
    }
    
    func makeCoordinator() -> ChatViewCoordinator<ContentView> {
        return ChatViewCoordinator(contentView: viewBuilderClosure)
    }
}
