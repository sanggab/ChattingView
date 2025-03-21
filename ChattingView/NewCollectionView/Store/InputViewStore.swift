//
//  InputViewStore.swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct InputViewStore {
    @ObservableState
    struct State: Equatable {
        var text: String = ""
        var isFocused: Bool = false
    }
    
    enum Action: Equatable {
        case updateText(String)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .updateText(let text):
                state.text = text
                return .none
            }
        }
    }
}
