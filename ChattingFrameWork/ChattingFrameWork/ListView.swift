//
//  ListView.swift
//  ChattingFrameWork
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import Core

import Kingfisher
import ComposableArchitecture

struct ListView: View {
    let store: StoreOf<ChattingStore>
    
    var body: some View {
        let _ = Self._printChanges()
        
        WithPerceptionTracking {
            LazyVStack(spacing: 0) {
                ForEach(store.list) { (chatModel: ChatModel) in
                    switch chatModel.chatType {
                    case .text:
                        Text(chatModel.text)
                            .onAppear {
                                print("상갑 logEvent \(#function) text")
                            }
                    case .img:
                        KFImage(URL(string: chatModel.imgUrl ?? ""))
                            .resizable()
                            .frame(width: 300, height: 300)
                            .onAppear {
                                print("상갑 logEvent \(#function) img")
                            }
                    case .delete:
                        Text("deleted Message")
                            .onAppear {
                                print("상갑 logEvent \(#function) delete")
                            }
                    }
                }
            }
        }
    }
}

//#Preview {
//    ListView()
//}
