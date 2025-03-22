//
//  CUViewModel.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

final class CUViewModel: ObservableObject, ViewModelFeatures {
    
    struct State: Equatable {
        var list: [ChatModel] = []
        var chatState: UpdateType = .none
        var msgNo: Int = 0
    }
    
    enum Action: Equatable {
        case onAppear
        case append
        case appendImg
        case delete(ChatModel)
        case changeUpdateType(UpdateType)
    }
    
    @Published private var state: State = .init()
    
    func callAsFunction<V>(_ keyPath: KeyPath<State, V>) -> V where V: Equatable {
        return state[keyPath: keyPath]
    }
    
    func action(_ action: Action) {
        print("\(#function) action: \(action)")
        switch action {
        case .onAppear:
            self.update(\.list, newValue: ChatModel.makeEmptyData())
            self.action(.changeUpdateType(.scrollToBottom))
        case .append:
            let textRandomeElement: String = [
                "가나다라1",
                "가나다라2",
                "가나다라3",
                "가나다라4",
                "가나다라5",
                "가나다라6",
                "가나다라7",
                "가나다라8",
                "가나다라9",
                "가나다라10",
                "가나다라11",
                "가나다라12",
                "가나다라13",
                "가나다라14",
                "가나다라15",
                "가나다라16",
                "가나다라17"
            ].randomElement() ?? "엣큥"
            
            var list: [ChatModel] = self(\.list)
            let msgNo: Int = self(\.msgNo)
            list.append(.init(memNo: 2805, chatType: .text, sendType: .send, text: textRandomeElement, imgUrl: nil, msgNo: msgNo))
            self.update(\.list, newValue: list)
            self.update(\.msgNo, newValue: msgNo + 1)
            self.action(.changeUpdateType(.scrollToBottom))
            
        case .appendImg:
            let imgUrl: String = [
                "https://upload3.inven.co.kr/upload/2021/12/21/bbs/i15560686762.jpg?MW=800",
                "https://upload3.inven.co.kr/upload/2023/11/21/bbs/i17226991301.png",
                "https://upload3.inven.co.kr/upload/2023/04/03/bbs/i16565482795.jpg",
//                "https://upload3.inven.co.kr/upload/2021/12/21/bbs/i15560686762.jpg?MW=800",
//                "https://upload3.inven.co.kr/upload/2021/12/21/bbs/i15560686762.jpg?MW=800",
//                "https://upload3.inven.co.kr/upload/2021/12/21/bbs/i15560686762.jpg?MW=800",
//                "https://upload3.inven.co.kr/upload/2021/12/21/bbs/i15560686762.jpg?MW=800",
//                "https://upload3.inven.co.kr/upload/2021/12/21/bbs/i15560686762.jpg?MW=800",
//                "https://upload3.inven.co.kr/upload/2021/12/21/bbs/i15560686762.jpg?MW=800",
//                "https://upload3.inven.co.kr/upload/2021/12/21/bbs/i15560686762.jpg?MW=800"
            ].randomElement() ?? "안댕"
            
            let msgNo: Int = self(\.msgNo)
            var list: [ChatModel] = self(\.list)
            list.append(.init(memNo: 2805, chatType: .img, sendType: .send, text: "", imgUrl: imgUrl, msgNo: msgNo))
            self.update(\.list, newValue: list)
            self.update(\.msgNo, newValue: msgNo + 1)
            self.action(.changeUpdateType(.scrollToBottom))
            
        case .delete(let model):
            let list: [ChatModel] = self(\.list)
            guard let index: Array<ChatModel>.Index = list.firstIndex(where: { $0 == model }) else { return }
            print("상갑 logEvent \(#function) delete index: \(index)")
            list[index].chatType = .delete
            
//            list.enumerated().forEach { index, data in
//                print("상갑 logEvent \(#function) index: \(index)")
//                print("상갑 logEvent \(#function) chatType: \(data.chatType)")
//                print("상갑 logEvent \(#function) id: \(data.id)")
//            }
            self.update(\.list, newValue: list)
            self.action(.changeUpdateType(.reconfigure))
            
        case .changeUpdateType(let type):
            print("상갑 logEvent \(#function) type: \(type)")
            self.update(\.chatState, newValue: type)
        }
    }
}

extension CUViewModel {
    private func update<V>(_ keyPath: WritableKeyPath<State, V>, newValue: V) where V: Equatable {
        self.state[keyPath: keyPath] = newValue
    }
}
