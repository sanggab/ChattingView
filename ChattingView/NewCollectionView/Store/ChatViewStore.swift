//
//  ChatViewStore.swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

import ComposableArchitecture

@Reducer
struct ChatViewStore {
    @ObservableState
    struct State: Equatable {
        var inputState: InputViewStore.State?
        var scrollViewState: ScrollViewStore.State?
//        var list: [ListModel]
    }
    
    enum Action: Equatable {
//        case updateList([ListModel])
        case onAppear
        case inputViewAction(InputViewStore.Action)
        case scrollViewAction(ScrollViewStore.Action)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.inputState = InputViewStore.State()
                state.scrollViewState = ScrollViewStore.State()
                return .none
            case .inputViewAction(let action):
                return .none
            case .scrollViewAction(let action):
                return .none
            }
        }
        .ifLet(\.inputState, action: \.inputViewAction) {
            InputViewStore()
        }
        .ifLet(\.scrollViewState, action: \.scrollViewAction) {
            ScrollViewStore()
        }
    }
}

