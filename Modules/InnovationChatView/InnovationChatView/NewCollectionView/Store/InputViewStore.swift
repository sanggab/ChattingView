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
        var textViewHeight: CGFloat = 0
        var keyboardHeight: CGFloat = 0
    }
    
    enum Action: Equatable {
        case updateText(String)
        case updateIsFocused(Bool)
        case updateTextViewHeight(CGFloat)
        case updateKeyboardHeight(CGFloat)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .updateText(let text):
                state.text = text
                return .none
            case .updateIsFocused(let isFocused):
                state.isFocused = isFocused
                return .none
            case .updateTextViewHeight(let height):
                state.textViewHeight = height
                return .none
            case .updateKeyboardHeight(let height):
                state.keyboardHeight = height
                return .none
            }
        }
    }
}
