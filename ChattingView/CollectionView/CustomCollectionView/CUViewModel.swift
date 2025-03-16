//
//  CUViewModel.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

enum ChatSection: Int, Equatable {
    case main = 0
}

enum ChatType: CaseIterable, Equatable {
    case text
    case img
    case delete
}

enum SendType: CaseIterable, Equatable {
    case send
    case receive
}

enum UpdateType: CaseIterable, Equatable {
    case none
    case reload
    case reconfigure
    case scrollToBottom
}

class ChatModel: Hashable, Identifiable {
    static func == (lhs: ChatModel, rhs: ChatModel) -> Bool {
        lhs.memNo == rhs.memNo &&
        lhs.chatType == rhs.chatType &&
        lhs.sendType == rhs.sendType &&
        lhs.text == rhs.text &&
        lhs.imgUrl == rhs.imgUrl &&
        lhs.msgNo == rhs.msgNo
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.memNo)
        hasher.combine(self.chatType)
        hasher.combine(self.sendType)
        hasher.combine(self.text)
        hasher.combine(self.imgUrl)
        hasher.combine(self.msgNo)
    }
    
    typealias ID = String
    
    var id: ID = UUID().uuidString
    
    var memNo: Int
    var chatType: ChatType
    var sendType: SendType
    var text: String
    var imgUrl: String?
    var msgNo: Int
    
    init(memNo: Int, chatType: ChatType, sendType: SendType, text: String = "", imgUrl: String? = nil, msgNo: Int) {
        self.memNo = memNo
        self.chatType = chatType
        self.sendType = sendType
        self.text = text
        self.imgUrl = imgUrl
        self.msgNo = msgNo
    }
    
    static func makeEmptyData() -> [ChatModel] {
        return [
            ChatModel(memNo: 2805, chatType: .text, sendType: .send, text: "안녕! 첫 번째 메시지야!", imgUrl: nil, msgNo: 99999999),
            ChatModel(memNo: 3699, chatType: .text, sendType: .send, text: "안녕! 둘 번째 메시지야!", imgUrl: nil, msgNo: 99999999),
            ChatModel(memNo: 2805, chatType: .text, sendType: .send, text: "안녕! 셋 번째 메시지야!", imgUrl: nil, msgNo: 99999999),
            ChatModel(memNo: 2805, chatType: .img, sendType: .send, text: "안녕! 넷 번째 메시지야!", imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSohVs9nQ1O_NjtL0Bg0RiOFBKXU3Kgv327-A&s", msgNo: 99999999),
            ChatModel(memNo: 3699, chatType: .text, sendType: .send, text: "안녕! 다섯 번째 메시지야!", imgUrl: nil, msgNo: 99999999),
            ChatModel(memNo: 3699, chatType: .img, sendType: .send, text: "안녕! 여셧 번째 메시지야!", imgUrl: "https://upload3.inven.co.kr/upload/2023/03/29/bbs/i15472657350.jpg", msgNo: 99999999),
            ChatModel(memNo: 2805, chatType: .text, sendType: .send, text: "안녕! 일곱 번째 메시지야!", imgUrl: nil, msgNo: 99999999),
            ChatModel(memNo: 3699, chatType: .img, sendType: .send, text: "안녕! 여덟 번째 메시지야!", imgUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_z2Jno6IFeX6KIS0qHoa-bQYvS0dwcCiuMNe2O_Yrv3UPfk3ZTsjy-V-wlenduXaWI38&usqp=CAU", msgNo: 99999999),
            ChatModel(memNo: 3699, chatType: .img, sendType: .send, text: "안녕! 아홉 번째 메시지야!", imgUrl: "https://upload3.inven.co.kr/upload/2023/02/25/bbs/i14655432921.jpg", msgNo: 99999999),
            ChatModel(memNo: 3699, chatType: .text, sendType: .send, text: "안녕! 열 번째 메시지야!", imgUrl: nil, msgNo: 99999999),
            ChatModel(memNo: 2805, chatType: .text, sendType: .send, text: "안녕! 열 하나 번째 메시지야!", imgUrl: nil, msgNo: 99999999)
        ]
    }
}


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
            var msgNo: Int = self(\.msgNo)
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
            
            var msgNo: Int = self(\.msgNo)
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
