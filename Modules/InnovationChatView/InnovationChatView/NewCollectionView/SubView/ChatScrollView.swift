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
    
    @State private var hoho: CGFloat = 0
    
    var body: some View {
        let _ = Self._printChanges()
        WithPerceptionTracking {
            ChatCollectionView(contentView: {
                LazyVStack(spacing: 0) {
                    listView
                    listView
                }
                .getSize { size in
                    self.store.send(.updateListHeight(size.height))
                }
            }, store: store, offsetY: hoho)
            .getSize { size in
                self.store.send(.updateScrollViewHeight(size.height))
            }
            .onChange(of: store.keyboardHeight) { newValue in
                print("\(#function) newValue: \(newValue)")
                
                if newValue != 0 {
                    let listHeigh: CGFloat = self.store.listHeight
                    let scrollViewHeight: CGFloat = self.store.scrollViewHeight
                    let keyboardHeight: CGFloat = newValue
                    
                    print("\(#function) listHeigh: \(listHeigh)")
                    print("\(#function) scrollViewHeight: \(scrollViewHeight)")
                    print("\(#function) textViewHeight: \(keyboardHeight)")
                    
                    let offsetY = scrollViewHeight - listHeigh - keyboardHeight
                    self.hoho = abs(offsetY)
                    self.store.send(.updateState(.scrollToBottom))
                    print("\(#function) offsetY: \(offsetY)")
                } else {
                    self.hoho = 0
                }
            }
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
