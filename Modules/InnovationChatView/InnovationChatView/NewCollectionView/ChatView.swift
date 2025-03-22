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
    
    var body: some View {
        let _ = Self._printChanges()
        WithPerceptionTracking {
            VStack(spacing: 0) {
                if let scrollViewStore = store.scope(state: \.scrollViewState, action: \.scrollViewAction) {
                    ChatScrollView(store: scrollViewStore)
                } else {
                    Text("scrollViewStore 없네")
                }
                
                
                if let inputViewStore = store.scope(state: \.inputState, action: \.inputViewAction) {
                    ChatInputView(store: inputViewStore)
                        .background(.random)
                } else {
                    Text("inputViewStore 없네")
                }
            }
            .onAppear {
                store.send(.onAppear)
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
