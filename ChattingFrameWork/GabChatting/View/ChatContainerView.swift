//
//  ChatContainerView.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

import ChattingUtils

public struct ChatContainerView<ContentView: View>: View, Equatable {
    public static func == (lhs: ChatContainerView<ContentView>, rhs: ChatContainerView<ContentView>) -> Bool {
        lhs.blankHeight == rhs.blankHeight &&
        lhs.collectionViewHeight == rhs.collectionViewHeight &&
        lhs.viewBuilderHeight == rhs.viewBuilderHeight
    }
    
    
    
    
    @ViewBuilder private var viewBuilderClosure: () -> ContentView
    
    @State private var blankHeight: CGFloat = 0
    @State private var collectionViewHeight: CGFloat = 0
    @State private var viewBuilderHeight: CGFloat = 0
    
    public init(@ViewBuilder contentView: @escaping () -> ContentView) {
        self.viewBuilderClosure = contentView
    }
    
    public var body: some View {
        let _ = Self._printChanges()
        
        ChattingCollectionView {
            VStack(spacing: 0) {
                
                viewBuilderClosure()
                    .getSize { size in
                        viewBuilderHeight = size.height
                    }
                
                Rectangle()
                    .fill(.pink)
                    .frame(height: blankHeight)
            }
            .rotationEffect(Angle(degrees: 180))
        }
        .rotationEffect(Angle(degrees: 180))
        .getSize { size in
            collectionViewHeight = size.height
        }
        .onChange(of: viewBuilderHeight) { newValue in
            print("상갑 logEvent \(#function) viewBuilderHeight: \(newValue)")
            
            print("상갑 logEvent \(#function) collectionViewHeight: \(collectionViewHeight)")
            if newValue >= collectionViewHeight {
                blankHeight = .zero
                print("상갑 logEvent \(#function) 1")
            } else {
                blankHeight = collectionViewHeight - newValue
                print("상갑 logEvent \(#function) 2")
            }
            
            print("상갑 logEvent \(#function) blankHeight: \(blankHeight)")
        }
    }
}

#Preview {
    ChatContainerView {
        Text("hi")
    }
}
