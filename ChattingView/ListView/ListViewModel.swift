//
//  ListViewModel.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

protocol ViewModelFeatures {
    associatedtype State: Equatable
    associatedtype Action: Equatable
    
    func callAsFunction<V: Equatable>(_ keyPath: KeyPath<State, V>) -> V
    
    func action(_ action: Action)
}

enum ListType: CaseIterable, Equatable {
    case text
    case img
}

class ListModel: Equatable {
    static func == (lhs: ListModel, rhs: ListModel) -> Bool {
        lhs.memNo == rhs.memNo &&
        lhs.type == rhs.type
    }
    
    var memNo: Int
    var type: ListType
    
    init(memNo: Int, type: ListType) {
        self.memNo = memNo
        self.type = type
    }
}

class ListViewModel: ObservableObject, ViewModelFeatures {
    
    struct State: Equatable {
        var list: [ListModel] = []
    }
    
    enum Action: Equatable {
        case onAppear
    }
    
    @Published private var state: State = .init()
    
    func callAsFunction<V>(_ keyPath: KeyPath<State, V>) -> V where V : Equatable {
        return state[keyPath: keyPath]
    }
    
    func action(_ action: Action) {
        print("\(#function) action: \(action)")
        switch action {
        case .onAppear:
            print("hi")
        }
    }
}
