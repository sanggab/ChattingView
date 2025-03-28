//
//  ChatContainerView.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

import GabTextView
import ChattingUtils

struct InputHeightKey: PreferenceKey {
    public static var defaultValue: CGFloat = .zero
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ListHeightKey: PreferenceKey {
    public static var defaultValue: CGFloat = .zero
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct ContainerHeightKey: PreferenceKey {
    public static var defaultValue: CGFloat = .zero
    
    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

public struct ChatContainerView<ContentView: View, ContentView2: View>: View {
    
    @ViewBuilder private var listViewClosure: () -> ContentView
    
    @ViewBuilder private var inputViewClosure: (() -> ContentView2)
    
    @State private var keyboardOption: KeyboardOption = .default
    @State private var inputHeight: CGFloat = 0
    @State private var safeInsetBottom: CGFloat = 0
    
    public init(@ViewBuilder listViewClosure: @escaping () -> ContentView,
                @ViewBuilder inputViewClosure: @escaping () -> ContentView2) {
        self.listViewClosure = listViewClosure
        self.inputViewClosure = inputViewClosure
    }
    
    public var body: some View {
        let _ = Self._printChanges()
        
        VStack(spacing: 0) {
            ChattingCollectionView(viewBuilderClosure: {
                listViewClosure()
                    .background(.blue)
            }, keyboardOption: $keyboardOption, inputHeight: inputHeight, safeAreaInsetBottom: safeInsetBottom)
            
            inputViewClosure()
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: InputHeightKey.self, value: proxy.size.height)
                            .onAppear {
                                self.safeInsetBottom = proxy.safeAreaInsets.bottom
                            }
                    }
                }
        }
        .keyboardWillShow { option in
            print("상갑 logEvent \(#function) keyboardWillShow: \(option)")
//            keyboardHeight = option.size.height
            keyboardOption = option
        }
        .keyboardWillHide { option in
            print("상갑 logEvent \(#function) keyboardWillHide: \(option)")
            keyboardOption = option
        }
        .onPreferenceChange(InputHeightKey.self) { inputHeight = $0 }
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @State var text: String = ""
    
    ChatContainerView {
        Text("hi")
            .font(.headline)
    } inputViewClosure: {
        TextView(text: $text)
            .textViewConfiguration { textView in
                textView.textContainer.lineFragmentPadding = .zero
                textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                textView.backgroundColor = .white
            }
            .setTextViewAppearanceModel(.default)
            .overlayPlaceHolder(.leading) {
                Text("메시지를 입력해주세요.")
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
    }

}


extension ChatContainerView {
    
    @ViewBuilder
    var listView: some View {
        VStack(spacing: 10) {
            Rectangle()
                .fill(.brown)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .fill(.brown)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .fill(.brown)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .fill(.brown)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .fill(.brown)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .fill(.brown)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .fill(.brown)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .fill(.brown)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
        }
    }
}
