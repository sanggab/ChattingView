//
//  CUMainView.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI
import Kingfisher

struct CUMainView: View {
    @StateObject var viewModel: CUViewModel = .init()
    
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
                ForEach(Array(viewModel(\.list).enumerated()), id: \.element.id) { index, data in
                    
                    switch data.chatType {
                    case .text:
                        CUTextCell(text: data.text)
                            .onAppear {
                                print("상갑 logEvent \(#function) Text")
                            }
                            .onTapGesture {
                                print("상갑 logEvent \(#function) TextText")
                            }
                            .onLongPressGesture {
                                print("\(#function) index: \(index)")
                                viewModel.action(.delete(data))
                            }
                    case .img:
                        CUImgCell(url: data.imgUrl)
                            .onAppear {
                                print("상갑 logEvent \(#function) KFImage")
                            }
                            .onTapGesture {
                                print("상갑 logEvent \(#function) imgimg")
                            }
                            .onLongPressGesture {
                                print("\(#function) index: \(index)")
                                viewModel.action(.delete(data))
                            }
                    case .delete:
                        CUDeletedCell()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .environmentObject(viewModel)
        }
    }
}

extension CUMainView {
    @ViewBuilder
    var container: some View {
        ForEach(viewModel(\.list), id: \.id) { data in
            
            switch data.chatType {
            case .text:
                CUTextCell(text: data.text)
                    .onAppear {
                        print("상갑 logEvent \(#function) Text")
                    }
                    .onTapGesture {
                        print("상갑 logEvent \(#function) TextText")
                    }
                    .onLongPressGesture {
                        viewModel.action(.delete(data))
                    }
            case .img:
                CUImgCell(url: data.imgUrl)
                    .onAppear {
                        print("상갑 logEvent \(#function) KFImage")
                    }
                    .onTapGesture {
                        print("상갑 logEvent \(#function) imgimg")
                    }
                    .onLongPressGesture {
                        viewModel.action(.delete(data))
                    }
            case .delete:
                CUDeletedCell()
            }
        }
    }
}

#Preview {
    CUMainView()
}
