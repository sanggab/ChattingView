//
//  Store.swift
//  TestChatView
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import Core

import ChattingUtils
import ComposableArchitecture

@Reducer
struct ChattingStore {
    @ObservableState
    struct State: Equatable {
        var text: String = ""
        var isFocused: Bool = false
        var inputViewHeight: CGFloat = 0
        var list: IdentifiedArrayOf<ChatModel> = []
        var keyboardOption: KeyboardOption = .default
    }
    
    enum Action: Equatable {
        case onAppear
        case updateText(String)
        case updateIsFocused(Bool)
        case updateInputViewHeight(CGFloat)
        case appendList([ChatModel])
        case appendRandomList
        case updateKeyboardOption(KeyboardOption)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.list.append(contentsOf: ChatModel.makeEmptyData())
                return .none
            case .updateText(let text):
                state.text = text
                return .none
            case .updateIsFocused(let isFocused):
                state.isFocused = isFocused
                return .none
            case .updateInputViewHeight(let height):
                state.inputViewHeight = height
                return .none
            case .appendList(let list):
                state.list.append(contentsOf: list)
                return .none
            case .appendRandomList:
                let imgUrl: String = [
                    "https://upload3.inven.co.kr/upload/2021/12/21/bbs/i15560686762.jpg?MW=800",
                    "https://upload3.inven.co.kr/upload/2023/11/21/bbs/i17226991301.png",
                    "https://upload3.inven.co.kr/upload/2023/04/03/bbs/i16565482795.jpg",
                    "https://blog.kakaocdn.net/dn/wvqpM/btsGipRVL6d/AhIj0Nz1bIhwnuH0kPXxoK/img.png",
                    "https://blog.kakaocdn.net/dn/TuHKu/btsGh6ryrVl/dgGhaIJkTE6amKtPmPmjbk/img.png",
                    "https://blog.kakaocdn.net/dn/YmNKq/btsGfKpuSFE/cAK39BdCDBiQIGoMREv0jK/img.png",
                    "https://upload3.inven.co.kr/upload/2021/12/19/bbs/i14150561074.jpg?MW=800",
                    "https://upload3.inven.co.kr/upload/2023/04/18/bbs/i15352384603.jpg",
                    "https://upload3.inven.co.kr/upload/2022/01/15/bbs/i14731996853.jpg?MW=800",
                    "https://upload3.inven.co.kr/upload/2023/08/16/bbs/i16976596468.png"
                ].randomElement() ?? "안댕"
                
                let msgNo: Int = (state.list.last?.msgNo ?? .zero) + 1
                state.list.append(.init(memNo: 2805, chatType: .img, sendType: .send, text: "", imgUrl: imgUrl, msgNo: msgNo))
                return .none
            case .updateKeyboardOption(let option):
                state.keyboardOption = option
                return .none
            }
        }
    }
}
