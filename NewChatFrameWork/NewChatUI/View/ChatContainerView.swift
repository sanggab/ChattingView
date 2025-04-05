//
//  ChatContainerView.swift
//  NewChatUI
//
//  Created by 심상갑 on 4/5/25.
//

import SwiftUI

struct ChatContainerView<ContentView: View, NewChatListModel: Hashable>: View {
    
    @ViewBuilder let itemBuilderClosure: (NewChatCoordinator<ContentView, NewChatListModel>.ItemBuilderClosure) -> ContentView
    
    @Binding var chatList: [NewChatListModel]
    
    var body: some View {
        ChattingView(itemBuilderClosure: { a in
            self.itemBuilderClosure(a)
        }, keyboardOption: .constant(.default), updateState: .constant(.keyboard), inputHeight: 0, safeAreaInsetBottom: 0, chatList: $chatList)
    }
}

//#Preview {
//    ChatContainerView()
//}
