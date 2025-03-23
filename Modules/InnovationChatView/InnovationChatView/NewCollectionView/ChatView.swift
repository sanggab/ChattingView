//
//  ChatView.swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

import ComposableArchitecture

struct ChatView: View {
    let store: StoreOf<ChatViewStore> = Store(initialState: ChatViewStore.State(), reducer: {
        ChatViewStore()
    })
    
    @State private var offsetY: CGFloat = 0
    @State private var notchBottom: CGFloat = 0
    
    var body: some View {
        let _ = Self._printChanges()
        WithPerceptionTracking {
            ZStack {
                VStack(spacing: 0) {
                    ChatHeaderView()
                    
                    if let scrollViewStore = store.scope(state: \.scrollViewState, action: \.scrollViewAction) {
                        ChatScrollView(store: scrollViewStore)
                    } else {
                        Text("scrollViewStore 없네")
                    }
                    
                    if let inputViewStore = store.scope(state: \.inputState, action: \.inputViewAction) {
                        ChatInputView(store: inputViewStore)
                            .background(.orange)
                    } else {
                        Text("inputViewStore 없네")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .onAppear {
                    store.send(.onAppear)
                }
            }
        }
        .onTapGesture {
            store.send(.inputViewAction(.updateIsFocused(false)))
        }
    }
}

#Preview {
    ChatView()
}
