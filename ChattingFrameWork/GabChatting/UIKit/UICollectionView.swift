//
//  UICollectionView.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

import ChattingUtils

public enum ChattingState: Equatable {
    /// 맨 처음 시작 시
    case onAppear
    /// 작업 대기중
    case waiting
    /// 키보드 상태변화
    case keyboard
    /// 채팅입력 상태
    case textInput
    /// Cell 재구성
    case reconfigure
    /// 재로드
    case reload
    /// 새로고침
    case refresh
}

public struct ChattingCollectionView<ContentView: View>: UIViewRepresentable {
    
    @ViewBuilder let viewBuilderClosure: () -> ContentView
    
    @Binding var keyboardOption: KeyboardOption
    let inputHeight: CGFloat
    let safeAreaInsetBottom: CGFloat
    
    @Binding var updateState: ChattingState
    @State var previousInputHeight: CGFloat = 0
    @State var previousKeyboardHeight: CGFloat = 0
    
    public init(@ViewBuilder viewBuilderClosure: @escaping () -> ContentView,
         keyboardOption: Binding<KeyboardOption>,
         updateState: Binding<ChattingState>,
         inputHeight: CGFloat,
         safeAreaInsetBottom: CGFloat) {
        self.viewBuilderClosure = viewBuilderClosure
        self._updateState = updateState
        self._keyboardOption = keyboardOption
        self.inputHeight = inputHeight
        self.safeAreaInsetBottom = safeAreaInsetBottom
    }
    
    public func makeUIView(context: Context) -> UICollectionView {
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
    
    public func updateUIView(_ uiView: UICollectionView, context: Context) {
        print("\(#function) updateState: \(self.updateState)")
        self.conditionUpdateType(uiView, context: context)
        self.dataInput(uiView, context: context)
    }
    
    public func makeCoordinator() -> ChattingCoordinator<ContentView> {
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
            self.textInputAction(uiView)
        case .keyboard:
            self.controlOffsetWithKeyboard(uiView)
        case .reconfigure:
            self.reconfigureAction(uiView, context: context)
        case .reload:
            self.reloadAction(uiView, context: context)
        case .refresh:
            context.coordinator.reconfigureItems()
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
