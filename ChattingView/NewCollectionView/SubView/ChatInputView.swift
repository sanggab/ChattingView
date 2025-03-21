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
                .receiveTextViewHeight { textViewHeight = $0 }
                .overlayPlaceHolder(.leading) {
                    Text("Input Message")
                }
                .frame(height: textViewHeight)
                .frame(maxWidth: .infinity)
                .focused(<#T##FocusState<Bool>.Binding#>)
        }
    }
}

#Preview {
    let store = Store(initialState: InputViewStore.State()) {
        InputViewStore()
    }
    
    ChatInputView(store: store)
}
