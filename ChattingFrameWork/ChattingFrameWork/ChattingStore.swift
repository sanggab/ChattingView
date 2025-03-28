//
//  ChattingStore.swift
//  ChattingFrameWork
//
//  Created by Gab on 3/28/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct ChattingStore {
    @ObservableState
    struct State: Equatable {
        var text: String = ""
        var isFocused: Bool = false
        var inputViewHeight: CGFloat = 0
    }
    
    enum Action: Equatable {
        case updateText(String)
        case updateIsFocused(Bool)
        case updateInputViewHeight(CGFloat)
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
            case .updateInputViewHeight(let height):
                state.inputViewHeight = height
                return .none
            }
        }
    }
}
