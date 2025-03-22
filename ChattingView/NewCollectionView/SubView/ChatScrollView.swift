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
    
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        let _ = Self._printChanges()
        ScrollView {
            
            Group {
                Text("hi")
                listView
                listView
                listView
                listView
            }
            .rotationEffect(.degrees(180)).scaleEffect(x: -1, y: 1, anchor: .center)
        }
        .rotationEffect(.degrees(180)).scaleEffect(x: -1, y: 1, anchor: .center)
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
        }
    }
}

#Preview {
    let store = Store(initialState: ScrollViewStore.State()) {
        ScrollViewStore()
    }
    
    ChatScrollView(store: store)
}
