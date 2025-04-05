//
//  ContentView.swift
//  RepresentableChatting
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import Core

import Kingfisher
import NewChatUI
import NewChatModel
import ComposableArchitecture

struct ContentView: View {
    @Perception.Bindable var store: StoreOf<ChattingStore>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(.pink)
                        .onTapGesture {
                            store.send(.appendRandomList)
                            store.send(.updateChattingState(.reconfigure))
                        }
                    
                    Rectangle()
                        .fill(.mint)
                        .onTapGesture {
                            store.send(.appendRandomList)
                            store.send(.updateChattingState(.test))
                        }
                }
                .frame(height: 50)
                
                ChattingView(itemBuilderClosure: { (beforeItem: ChatModel?, currentItem: ChatModel) in
                    switch currentItem.chatType {
                    case .text:
                        Text(currentItem.text)
                            .font(.headline)
                            .foregroundStyle(.black)
                    case .img:
                        KFImage(URL(string: currentItem.imgUrl ?? ""))
                            .resizable()
                            .frame(width: 300, height: 300)
                    case .delete:
                        Text("Deleted Message")
                            .font(.headline)
                            .foregroundStyle(.red)
                    }
                }, keyboardOption: $store.keyboardOption.sending(\.updateKeyboardOption), updateState: $store.chattingState.sending(\.updateChattingState), inputHeight: 0, safeAreaInsetBottom: 0, chatList: $store.list.sending(\.updateChatList))
                .task {
                    store.send(.updateChatList(ChatModel.makeEmptyData()))
                    store.send(.updateChattingState(.reload))
                }
            }
        }
    }
}

#Preview {
    let store: StoreOf<ChattingStore> =  .init(initialState: ChattingStore.State()) {
        ChattingStore()
    }
    
    ContentView(store: store)
}
