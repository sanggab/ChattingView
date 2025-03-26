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
    
    @State var text: String = ""
    @FocusState private var isFocused: Bool
    
    @State private var blankHeight: CGFloat = 0
    @State private var collectionViewHeight: CGFloat = 0
    @State private var viewBuilderHeight: CGFloat = 0
    @State private var inputViewHeight: CGFloat = 0
    
    public init(@ViewBuilder listViewClosure: @escaping () -> ContentView,
                @ViewBuilder inputViewClosure: @escaping () -> ContentView2) {
        self.listViewClosure = listViewClosure
        self.inputViewClosure = inputViewClosure
    }
    
    public var body: some View {
        let _ = Self._printChanges()
        
        VStack(spacing: 0) {
            ChattingCollectionView(viewBuilderClosure: {
                Group {
                    listViewClosure()
                        .background(.blue)
                        .background {
                            GeometryReader { proxy in
                                Color.clear
                                    .preference(key: ListHeightKey.self, value: proxy.size.height)
                            }
                        }
                    
                }
            }, blankHeight: $blankHeight)
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: ContainerHeightKey.self, value: proxy.size.height)
                }
            }

            
            inputViewClosure()
                .focused($isFocused)
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: InputHeightKey.self, value: proxy.size.height)
                    }
                }
        }
        .onPreferenceChange(ListHeightKey.self, perform: { value in
            self.viewBuilderHeight = value
        })
        .onPreferenceChange(ContainerHeightKey.self, perform: { value in
            self.collectionViewHeight = value
        })
        .onPreferenceChange(InputHeightKey.self, perform: { value in
            self.inputViewHeight = value
        })
        .keyboardWillShow { option in
            print("상갑 logEvent \(#function) keyboardWillShow: \(option)")
            
            print("상갑 logEvent \(#function) collectionViewHeight: \(collectionViewHeight)")
            
            print("상갑 logEvent \(#function) viewBuilderHeight: \(viewBuilderHeight)")
            
            print("상갑 logEvent \(#function) inputViewHeight: \(inputViewHeight)")
            
            
//            if collectionViewHeight <= viewBuilderHeight {
//                blankHeight = option.size.height - inputViewHeight
//            } else {
//                blankHeight = collectionViewHeight - viewBuilderHeight - option.size.height
//            }
        }
        .keyboardWillHide { option in
            print("상갑 logEvent \(#function) keyboardWillHide: \(option)")
            withAnimation(option.makingCurveAnimation()) {
                blankHeight = 0
            }
        }
        .onChange(of: blankHeight) { newValue in
            print("상갑 logEvent \(#function) blankHeight: \(blankHeight)")
        }
        .onChange(of: isFocused) { newValue in
            print("상갑 logEvent \(#function) isFocused: \(isFocused)")
        }
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
