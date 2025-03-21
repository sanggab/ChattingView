//
//  KeyboardView.swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

import GabTextView

struct KeyboardView: View {
    @State private var text: String = ""
    @State private var height: CGFloat = 0
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: .zero) {
            TextView(text: $text)
                .textViewConfiguration { textView in
                    textView.backgroundColor = .systemMint
                    textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                    textView.textContainer.lineFragmentPadding = .zero
                    textView.textColor = .black
                }
//                .setTextViewAppearanceModel(.default)
                .controlTextViewDelegate(.automatic)
                .receiveTextViewHeight { height = $0 }
                .overlayPlaceHolder(.leading) {
                    Text("플레이스 홀더")
                }
                .focused($isFocused)
                .frame(height: height)
                .frame(maxWidth: .infinity)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
        .onTapGesture {
            isFocused.toggle()
        }
    }
}

#Preview {
    KeyboardView()
}
