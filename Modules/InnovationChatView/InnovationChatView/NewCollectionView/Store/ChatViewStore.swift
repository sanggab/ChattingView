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
                return self.inputViewAction(action: action)
                
            case .scrollViewAction(let action):
                return self.scrollViewAction(action: action)
            }
        }
        .ifLet(\.inputState, action: \.inputViewAction) {
            InputViewStore()
        }
        .ifLet(\.scrollViewState, action: \.scrollViewAction) {
            ScrollViewStore()
        }
    }
    
    func inputViewAction(action: InputViewStore.Action) -> Effect<Action> {
        switch action {
        case .updateText(let string):
//            print("\(#file) \(#function) string: \(string)")
            return .none
            
        case .updateIsFocused(let bool):
//            print("\(#file) \(#function) updateIsFocused: \(bool)")
            return .send(.scrollViewAction(.updateIsFocused(bool)))
            
        case .updateTextViewHeight(let cGFloat):
//            print("\(#file) \(#function) updateTextViewHeight: \(cGFloat)")
            return .send(.scrollViewAction(.updateTextViewHeight(cGFloat)))
            
        case .updateKeyboardHeight(let cGFloat):
            print("\(#function) updateKeyboardHeight: \(cGFloat)")
            return .send(.scrollViewAction(.updateKeyboardHeight(cGFloat)))
        }
    }
    
    func scrollViewAction(action: ScrollViewStore.Action) -> Effect<Action> {
        switch action {
        case .updateState(let updateType):
            print("\(#file) \(#function) updateState: \(updateType)")
            return .none
            
        case .updateList(let array):
//            print("\(#file) \(#function) updateList: \(array)")
            return .none
            
        case .updateScrollViewHeight(let cGFloat):
//            print("\(#file) \(#function) updateScrollViewHeight: \(cGFloat)")
            return .none
            
        case .updateListHeight(let cGFloat):
//            print("\(#file) \(#function) updateListHeight: \(cGFloat)")
            return .none
            
        case .updateIsFocused(let bool):
//            print("\(#file) \(#function) updateIsFocused: \(bool)")
            return .none
        case .updateTextViewHeight(let cGFloat):
            return .none
            
        case .updateKeyboardHeight(let cGFloat):
            return .none
        }
    }
}

