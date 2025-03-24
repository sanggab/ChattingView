//
//  ScrollViewStore.swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

import Core
import ComposableArchitecture

@Reducer
struct ScrollViewStore {
    @ObservableState
    struct State: Equatable {
        var updateState: UpdateType = .none
        var list: IdentifiedArrayOf<ChatModel> = []
        var scrollViewHeight: CGFloat = 0
        var listHeight: CGFloat = 0
        var isFocused: Bool = false
        var textViewHeight: CGFloat = 0
        var keyboardHeight: CGFloat = 0
    }
    
    enum Action: Equatable {
        case updateState(UpdateType)
        case updateList([ChatModel])
        case updateScrollViewHeight(CGFloat)
        case updateListHeight(CGFloat)
        case updateIsFocused(Bool)
        case updateTextViewHeight(CGFloat)
        case updateKeyboardHeight(CGFloat)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .updateState(let type):
                state.updateState = type
                return .none
                
            case .updateList(let model):
                state.list = IdentifiedArrayOf(uniqueElements: model)
                return .none
                
            case .updateScrollViewHeight(let height):
                state.scrollViewHeight = height
                return .none
                
            case .updateListHeight(let height):
                state.listHeight = height
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
