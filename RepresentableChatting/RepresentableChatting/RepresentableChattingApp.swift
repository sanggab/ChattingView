//
//  RepresentableChattingApp.swift
//  RepresentableChatting
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import ComposableArchitecture

@main
struct RepresentableChattingApp: App {
    
    let store: StoreOf<ChattingStore> =  .init(initialState: ChattingStore.State()) {
        ChattingStore()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
