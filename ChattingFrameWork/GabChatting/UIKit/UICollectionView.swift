//
//  UICollectionView.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

import ChattingUtils

enum ChattingState: Equatable {
    case onAppear
    case waiting
    case keyboard
//    case keyboardShow
//    case keyboardHide
    case textInput
}

struct ChattingCollectionView<ContentView: View>: UIViewRepresentable {
    
    @ViewBuilder let viewBuilderClosure: () -> ContentView
    
    @Binding var keyboardOption: KeyboardOption
    let inputHeight: CGFloat
    let safeAreaInsetBottom: CGFloat
    
    @State private var chattingState: ChattingState = .onAppear
    
    @State var updateState: ChattingState = .onAppear
    @State var previousInputHeight: CGFloat = 0
    @State var previousKeyboardHeight: CGFloat = 0
    
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
        print("\(#function) updateState: \(self.updateState)")
        self.conditionUpdateType(uiView, context: context)
    }
    
    func makeCoordinator() -> ChattingCoordinator<ContentView> {
        return ChattingCoordinator(viewBuilderClosure: self.viewBuilderClosure)
    }
}

extension ChattingCollectionView {
    func conditionUpdateType(_ uiView: UICollectionView, context: Context) {
        switch self.updateState {
        case .onAppear:
            self.onAppearAction(uiView, context: context)
        case .waiting:
            self.waitingAction()
        case .textInput:
            self.textInputAction(uiView, context: context)
        case .keyboard:
            self.controlOffsetWithKeyboard(uiView, context: context)
        }
    }
}
