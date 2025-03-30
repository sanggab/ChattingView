//
//  ContentView.swift
//  ChattingFrameWork
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

import GabTextView
import GabChatting

import Kingfisher
import ComposableArchitecture

struct ContentView: View {
    @State var text: String = ""
    @FocusState private var isFocused: Bool
    @State var inputViewHeight: CGFloat = 0
    
    @Perception.Bindable var store: StoreOf<ChattingStore> = .init(initialState: ChattingStore.State()) {
        ChattingStore()
    }
    
    var body: some View {
        let _ = Self._printChanges()
        WithPerceptionTracking {
            VStack(spacing: 0) {
                HStack {
                    Rectangle()
                        .fill(.pink.opacity(0.8))
                        .frame(height: 40)
                        .onTapGesture {
                            store.send(.appendRandomList)
                        }
                    
                    Rectangle()
                        .fill(.pink.opacity(0.8))
                        .frame(height: 40)
                        .onTapGesture {
                            
                        }
                }
                
                ChatContainerView {
                    LazyVStack(spacing: 0) {
                        ForEach(store.list) { chatModel in
                            KFImage(URL(string: chatModel.imgUrl ?? ""))
                                .resizable()
                                .frame(width: 300, height: 300)
                        }
                    }
                } inputViewClosure: {
                    TextView(text: $text)
                        .textViewConfiguration { textView in
                            textView.textContainer.lineFragmentPadding = .zero
                            textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                            textView.backgroundColor = .white
                        }
                        .limitLine(3)
                        .setTextViewAppearanceModel(.default)
                        .receiveTextViewHeight { height in
                            inputViewHeight = height
                        }
                        .overlayPlaceHolder(.leading) {
                            Text("메시지를 입력해주세요.")
                        }
                        .frame(height: inputViewHeight)
                        .frame(maxWidth: .infinity)
                        .focused($isFocused)
                }
                .onTapGesture {
                    isFocused.toggle()
                }
                .task {
                    store.send(.onAppear)
                }
            }
            .onChange(of: store.list) { newValue in
                print("\(#function) newValue: \(newValue)")
            }
        }
    }
    
    @ViewBuilder
    var listView: some View {
        VStack(spacing: 10) {
            Rectangle()
                .fill(.random)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
//                .onAppear {
//                    print("random : \((1...100).randomElement())")
//                }
//                .onDisappear {
//                    print("random : \((1...100).randomElement())")
//                }
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
//                .onAppear {
//                    print("random : \((1...100).randomElement())")
//                }
//                .onDisappear {
//                    print("random : \((1...100).randomElement())")
//                }
            
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
//                .onAppear {
//                    print("random : \((1...100).randomElement())")
//                }
//                .onDisappear {
//                    print("random : \((1...100).randomElement())")
//                }
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
//                .onAppear {
//                    print("random : \((1...100).randomElement())")
//                }
//                .onDisappear {
//                    print("random : \((1...100).randomElement())")
//                }
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
//                .onAppear {
//                    print("random : \((1...100).randomElement())")
//                }
//                .onDisappear {
//                    print("random : \((1...100).randomElement())")
//                }
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
//                .onAppear {
//                    print("random : \((1...100).randomElement())")
//                }
//                .onDisappear {
//                    print("random : \((1...100).randomElement())")
//                }
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
//                .onAppear {
//                    print("random : \((1...100).randomElement())")
//                }
//                .onDisappear {
//                    print("random : \((1...100).randomElement())")
//                }
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
//                .onAppear {
//                    print("random : \((1...100).randomElement())")
//                }
//                .onDisappear {
//                    print("random : \((1...100).randomElement())")
//                }
            
            Rectangle()
                .fill(.random)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
//                .onAppear {
//                    print("random : \((1...100).randomElement())")
//                }
//                .onDisappear {
//                    print("random : \((1...100).randomElement())")
//                }
        }
    }
}

#Preview {
    ContentView()
}
