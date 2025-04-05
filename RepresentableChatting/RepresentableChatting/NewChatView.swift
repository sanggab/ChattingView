//
//  NewChatView.swift
//  RepresentableChatting
//
//  Created by 심상갑 on 4/5/25.
//

import SwiftUI

import NewChatUI
import ChattingUtils
import GabTextView

import ComposableArchitecture

struct NewChatView: View {
    @Perception.Bindable var store: StoreOf<ChattingStore>
    
    var body: some View {
        ChatContainerView(itemBuilderClosure: { _ in
            EmptyView()
        }, inputBuilderClosure: {
            TextView(text: $store.text.sending(\.updateText))
                .textViewConfiguration { <#UITextView#> in
                    <#code#>
                }
        }, chatList: $store.list.sending(\.updateChatList))
    }
}

#Preview {
    let store: StoreOf<ChattingStore> =  .init(initialState: ChattingStore.State()) {
        ChattingStore()
    }
    
    NewChatView(store: store)
}
