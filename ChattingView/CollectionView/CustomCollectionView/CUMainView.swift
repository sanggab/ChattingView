//
//  CUMainView.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI
import Kingfisher

struct CUMainView: View {
    @StateObject var viewModel: CollectionViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.orange)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .topLeading) {
                    HStack {
                        Button {
                            viewModel.action(.onAppear)
                        } label: {
                            Text("데이터 초기 세팅")
                        }
                        .padding([.top, .leading], 12)
                        
                        Spacer()
                        
                        Button {
                            viewModel.action(.append)
                        } label: {
                            Text("텍스트 추가")
                        }
                        .padding([.top, .trailing], 12)
                        
                        Button {
                            viewModel.action(.appendImg)
                        } label: {
                            Text("이미지 추가")
                        }
                        .padding([.top, .trailing], 12)
                    }
                }
            
            CURepresentableView {
                ForEach(viewModel(\.list), id: \.id) { data in
                    
                    switch data.chatType {
                    case .text:
                        Text(data.text)
                            .foregroundStyle(.gray)
                            .font(.headline)
                    case .img:
                        KFImage(URL(string: data.imgUrl ?? ""))
                            .resizable()
                            .frame(width: 300, height: 300)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    CUMainView()
}
