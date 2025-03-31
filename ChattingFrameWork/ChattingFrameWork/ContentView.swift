//
//  ContentView.swift
//  ChattingFrameWork
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

import Core
import GabTextView
import GabChatting

import Kingfisher
import ComposableArchitecture

struct ContentView: View {
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
                    ListView(store: store)
                } inputViewClosure: {
                    InputView(store: store)
                }
                .onTapGesture {
                    store.send(.updateIsFocused(false))
                }
                .task {
                    store.send(.onAppear)
                }
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
