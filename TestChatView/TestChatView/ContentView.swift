//
//  ContentView.swift
//  TestChatView
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import Core

import Kingfisher

import GabChatting
import ChattingUtils

struct ContentView: View {
    @ObservedObject private var viewModel: ChatViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Rectangle()
                    .fill(.pink)
                    .onTapGesture {
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
                        
                        let msgNo: Int = (viewModel.list.last?.msgNo ?? .zero) + 1
                        
                        viewModel.list.append(.init(memNo: 2805, chatType: .img, sendType: .send, imgUrl: imgUrl, msgNo: msgNo))
                    }
                
                Rectangle()
                    .fill(.blue)
                    .onTapGesture {
                        viewModel.updateState = .reconfigure
                    }
            }
            .frame(height: 50)
            
            ChattingCollectionView(viewBuilderClosure: {
                LazyVStack(spacing: 0) {
                    ForEach(Array(viewModel.list.enumerated()), id: \.element) { (index, chatModel: ChatModel) in
                        switch chatModel.chatType {
                        case .text:
                            Text(chatModel.text)
                                .font(.headline)
                                .foregroundStyle(.black)
                                .onAppear {
                                    print("상갑 logEvent \(#function) text")
                                }
                                .id(chatModel.msgNo)
                        case .img:
                            KFImage(URL(string: chatModel.imgUrl ?? ""))
                                .resizable()
                                .frame(width: 300, height: 300)
                                .onAppear {
                                    print("상갑 logEvent \(#function) img")
                                }
                                .id(chatModel.msgNo)
                        case .delete:
                            Text("Deleted Message..")
                                .onAppear {
                                    print("상갑 logEvent \(#function) delete")
                                }
                                .id(chatModel.msgNo)
                        }
                    }
                }
                
            }, keyboardOption: $viewModel.keyboardOption,
                                   updateState: $viewModel.updateState,
                                   inputHeight: viewModel.inputHeight,
                                   safeAreaInsetBottom: viewModel.safeAreaInsetBottom)
            .keyboardWillShow { viewModel.keyboardOption = $0 }
            .keyboardWillHide { viewModel.keyboardOption = $0 }
        }
    }
}

#Preview {
    ContentView()
}
