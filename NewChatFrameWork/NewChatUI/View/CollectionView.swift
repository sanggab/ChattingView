//
//  CollectionView.swift
//  NewChatUI
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import Core

import NewChatModel
import ChattingUtils

public struct ChattingView<ContentView: View, NewChatListModel: Hashable>: UIViewRepresentable {
    
    @ViewBuilder let itemBuilderClosure: (NewChatCoordinator<ContentView, NewChatListModel>.ItemBuilderClosure) -> ContentView
    
    @Binding var keyboardOption: KeyboardOption
    let inputHeight: CGFloat
    let safeAreaInsetBottom: CGFloat
    
    @Binding var updateState: NewChattingState
    @State var previousInputHeight: CGFloat = 0
    @State var previousKeyboardHeight: CGFloat = 0
    @Binding var chatList: [NewChatListModel]
    
    public init(@ViewBuilder itemBuilderClosure: @escaping (NewChatCoordinator<ContentView, NewChatListModel>.ItemBuilderClosure) -> ContentView,
         keyboardOption: Binding<KeyboardOption>,
         updateState: Binding<NewChattingState>,
         inputHeight: CGFloat,
                safeAreaInsetBottom: CGFloat,
                chatList: Binding<[NewChatListModel]>) {
        self.itemBuilderClosure = itemBuilderClosure
        self._updateState = updateState
        self._keyboardOption = keyboardOption
        self.inputHeight = inputHeight
        self.safeAreaInsetBottom = safeAreaInsetBottom
        self._chatList = chatList
    }
    
    public func makeUIView(context: Context) -> UICollectionView {
        let collectionView: UICollectionView = .init(frame: .zero,
                                                     collectionViewLayout: context.coordinator.createCompositionalLayout())
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "chatcell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemMint
        collectionView.delegate = context.coordinator
        
        print("상갑 logEvent \(#function)")
        context.coordinator.setDataSource(view: collectionView)
        context.coordinator.setData(item: self.chatList)
        
        return collectionView
    }
    
    public func updateUIView(_ uiView: UICollectionView, context: Context) {
        print("\(#function) updateState: \(self.updateState)")
        self.conditionUpdateType(uiView, context: context)
        self.dataInput(uiView, context: context)
    }
    
    public func makeCoordinator() -> NewChatCoordinator<ContentView, NewChatListModel> {
        return NewChatCoordinator(itemBuilder: self.itemBuilderClosure)
    }
}

extension ChattingView {
    func conditionUpdateType(_ uiView: UICollectionView, context: Context) {
        switch self.updateState {
        case .onAppear:
            self.onAppearAction(uiView, context: context)
        case .waiting:
            self.waitingAction()
        case .textInput:
            self.textInputAction(uiView)
        case .keyboard:
            self.controlOffsetWithKeyboard(uiView)
        case .reconfigure:
            self.reconfigureAction(uiView, context: context)
        case .reload:
            self.reloadAction(uiView, context: context)
        case .refresh:
            context.coordinator.reconfigureItems()
        case .test:
            self.testAction(uiView, context: context)
        default:
            break
        }
    }
    
    func dataInput(_ uiView: UICollectionView, context: Context) {
        let height: CGFloat = uiView.frame.height
        let contentSize: CGFloat = uiView.contentSize.height
        
        print("상갑 logEvent \(#function) height: \(height)")
        print("상갑 logEvent \(#function) contentSize: \(contentSize)")
    }
}
