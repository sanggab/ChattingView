//
//  NewScrollView.swift
//  ChatScrollView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

import Combine
import ComposableArchitecture

struct ChatScrollView: View {
    
    let store: StoreOf<ScrollViewStore>
    
    let keyboardWillShowNotification = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification).compactMap(\.userInfo)
    
    let keyboardWillHideNotification = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification).compactMap(\.userInfo)
    
    var body: some View {
        let _ = Self._printChanges()
        ChatCollectionView(contentView: {
            LazyVStack(spacing: 0) {
                listView
            }
            .getSize { size in
                self.store.send(.updateListHeight(size.height))
            }
        }, store: store)
        .getSize { size in
            self.store.send(.updateScrollViewHeight(size.height))
        }
    }
}


extension ChatScrollView {
    @ViewBuilder
    var listView: some View {
        Group {
            Rectangle()
                .fill(.random)
                .frame(height: 50)
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
                .overlay(alignment: .bottom) {
                    Text("끝 영역")
                }
        }
    }
}

#Preview {
    let store = Store(initialState: ScrollViewStore.State()) {
        ScrollViewStore()
    }
    
    ChatScrollView(store: store)
}
