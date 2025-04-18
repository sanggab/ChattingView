//
//  KeyboardView.swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

import GabTextView

struct KeyboardView: View {
    
    @State private var offsetY: CGFloat = 0

    var body: some View {
        ScrollView {
            Text("hi")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
        .offset(y: offsetY)
        .onTapGesture {
            self.offsetY = self.offsetY == 0 ? 300 : 0
        }
    }
}

#Preview {
    KeyboardView()
}
