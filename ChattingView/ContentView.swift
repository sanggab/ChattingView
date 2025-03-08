//
//  ContentView.swift
//  ChattingView
//
//  Created by 심상갑 on 3/8/25.
//

import SwiftUI
import GabTextView

struct ContentView: View {
    @State var text: String = ""
    @State var textViewHeight: CGFloat = 0
    @FocusState var keyboardState: Bool
    
    var body: some View {
        ScrollView {
            
        }
        .background(.mint)
        .overlay(alignment: .bottom) {
            textView
                .modifier(KeyboardModifier())
        }
        .onTapGesture {
            keyboardState.toggle()
        }
        .ignoresSafeArea(.keyboard)
    }
}

extension ContentView {
    
    @ViewBuilder
    var textView: some View {
        TextView(text: $text)
            .textViewConfiguration { textView in
                textView.font = .boldSystemFont(ofSize: 20)
                textView.textColor = .gray
                textView.backgroundColor = .gray
                textView.setContentHuggingPriority(.defaultLow, for: .horizontal)
                textView.textContainerInset = .zero
                textView.textContainer.lineFragmentPadding = .zero
            }
            .controlTextViewDelegate(.automatic)
            .receiveTextViewHeight { height in
                self.textViewHeight = height
            }
            .overlayPlaceHolder(.leading) {
                Text("입력")
            }
            .frame(maxWidth: .infinity)
            .frame(height: textViewHeight)
            .focused($keyboardState)
    }
}

#Preview {
    ContentView()
}
