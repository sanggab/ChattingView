//
//  CUMainView.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

import Kingfisher
import GabTextView

struct CUMainView: View, Equatable {
    static func == (lhs: CUMainView, rhs: CUMainView) -> Bool {
        lhs.text == rhs.text &&
        lhs.height == rhs.height
    }
    
    @StateObject var viewModel: CUViewModel = .init()
    @State private var text: String = ""
    @State private var height: CGFloat = 100
    @FocusState private var isFocused: Bool
    
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
            
            VStack(spacing: 0) {
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
                
                TextView(text: $text)
                    .textViewConfiguration { textView in
                        textView.backgroundColor = .systemPink
                        textView.textContainer.lineFragmentPadding = .zero
                        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                        textView.isEditable = true
                    }
                    .setTextViewAppearanceModel(.default)
                    .controlTextViewDelegate(.automatic)
                    .receiveTextViewHeight { height = $0 }
                    .overlayPlaceHolder(.leading) {
                        Text("Input Message")
                    }
                    .focused($isFocused)
                    .frame(height: height)
                    .frame(maxWidth: .infinity)
            }
            .compositingGroup()
        }
        .onTapGesture {
            isFocused.toggle()
        }
        .onChange(of: isFocused) { newValue in
            if newValue {
                self.viewModel.action(.changeUpdateType(.isFoucsed))
            }
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
