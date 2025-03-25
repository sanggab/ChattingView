//
//  ChatContainerView.swift
//  InnovationChatView
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

struct ChatContainerView<ContentView: View>: View {
    
    @ViewBuilder var viewBuilderClosure: () -> ContentView
    
    init(@ViewBuilder contentView: @escaping () -> View) {
        self.viewBuilderClosure = viewBuilderClosure
    }
    
    var body: some View {
        Text("Hi")
    }
}

#Preview {
    ChatContainerView()
}
