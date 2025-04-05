//
//  ChatContainerView.swift
//  NewChatUI
//
//  Created by 심상갑 on 4/5/25.
//

import SwiftUI

import ChattingUtils
import NewChatModel

struct InputHeightKey: PreferenceKey {
    public static var defaultValue: CGFloat = .zero
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ListHeightKey: PreferenceKey {
    public static var defaultValue: CGFloat = .zero
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ContainerHeightKey: PreferenceKey {
    public static var defaultValue: CGFloat = .zero
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

public struct ChatContainerView<ContentView: View, InputView: View, NewChatListModel: Hashable>: View {
    
    @ViewBuilder private let itemBuilderClosure: (NewChatCoordinator<ContentView, NewChatListModel>.ItemBuilderClosure) -> ContentView
    
    @ViewBuilder private let inputBuilderClosure: () -> InputView
    
    @Binding public var chatList: [NewChatListModel]
    
    @State private var keyboardOption: KeyboardOption = .default
    @State private var updateState: NewChattingState = .waiting
    
    @State private var inputHeight: CGFloat = 0
    @State private var insetBottom: CGFloat = 0
    
    public init(itemBuilderClosure: @escaping (NewChatCoordinator<ContentView, NewChatListModel>.ItemBuilderClosure) -> ContentView, inputBuilderClosure: @escaping () -> InputView, chatList: Binding<[NewChatListModel]>) {
        self.itemBuilderClosure = itemBuilderClosure
        self.inputBuilderClosure = inputBuilderClosure
        self._chatList = chatList
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ChattingView(itemBuilderClosure: {
                self.itemBuilderClosure($0)
            },
                         keyboardOption: $keyboardOption,
                         updateState: .constant(.keyboard),
                         inputHeight: self.inputHeight,
                         safeAreaInsetBottom: self.insetBottom,
                         chatList: $chatList)
            
            inputBuilderClosure()
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .frame(width: 0, height: 0)
                            .hidden()
                            .preference(key: InputHeightKey.self, value: proxy.size.height)
                            .onAppear {
                                self.insetBottom = proxy.safeAreaInsets.bottom
                            }
                    }
                }
        }
        .onPreferenceChange(InputHeightKey.self) { self.inputHeight = $0 }
        .keyboardWillShow { option in
            self.updateState = .keyboard
            self.keyboardOption = option
        }
        .keyboardWillHide { option in
            self.updateState = .keyboard
            self.keyboardOption = option
        }
    }
}

//#Preview {
//    ChatContainerView()
//}
