//
//  ViewModel.swift
//  TestChatView
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import Core

import GabChatting
import ChattingUtils

final class ChatViewModel: ObservableObject {
    @Published var list: [ChatModel] = ChatModel.makeEmptyData()
    @Published var keyboardOption: KeyboardOption = .default
    @Published var inputHeight: CGFloat = 0
    @Published var safeAreaInsetBottom: CGFloat = 0
    @Published var updateState: ChattingState = .onAppear
    @FocusState var isFocused: Bool
}
