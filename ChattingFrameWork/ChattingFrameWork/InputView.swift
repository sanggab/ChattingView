//
//  InputView.swift
//  ChattingFrameWork
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import GabTextView
import ComposableArchitecture

struct InputView: View {
    @State var text: String = ""
    @State var inputViewHeight: CGFloat = 0
    
    @FocusState private var isFocused: Bool
    
    @Perception.Bindable var store: StoreOf<ChattingStore>
    
    var body: some View {
        let _ = Self._printChanges()
        
        WithPerceptionTracking {
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
                .bind($store.isFocused.sending(\.updateIsFocused), to: $isFocused)
        }
    }
}
