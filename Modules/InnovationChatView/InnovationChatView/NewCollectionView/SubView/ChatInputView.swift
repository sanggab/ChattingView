//
//  ChatInputView.swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

import GabTextView
import ComposableArchitecture

struct ChatInputView: View {
    @Perception.Bindable var store: StoreOf<InputViewStore>
    
    @FocusState private var focusTextView: Bool
    @State private var textViewHeight: CGFloat = 0
    
    var body: some View {
        let _ = Self._printChanges()
        WithPerceptionTracking {
            TextView(text: $store.text.sending(\.updateText))
                .textViewConfiguration { textView in
                    textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                    textView.backgroundColor = .white
                    textView.textContainer.lineFragmentPadding = .zero
                }
                .setTextViewAppearanceModel(.default)
                .receiveTextViewHeight { height in
                    self.textViewHeight = height
                }
                .overlayPlaceHolder(.leading) {
                    Text("Input Message")
                }
                .focused($focusTextView)
                .frame(height: self.textViewHeight)
                .frame(maxWidth: .infinity)
                .bind($store.isFocused.sending(\.updateIsFocused), to: $focusTextView)
                .keyboardWillShow { option in
                    store.send(.updateKeyboardHeight(option.size.height))
                }
                .keyboardWillHide { option in
                    store.send(.updateTextViewHeight(0))
                }
        }
        .onChange(of: self.textViewHeight) { newValue in
            self.store.send(.updateTextViewHeight(newValue))
        }
    }
}

#Preview {
    let store = Store(initialState: InputViewStore.State()) {
        InputViewStore()
    }
    
    ChatInputView(store: store)
}
