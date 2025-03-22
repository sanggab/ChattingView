//
//  ContentView.swift
//  KeyBoardTestApp
//
//  Created by 심상갑 on 3/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var offsetY: CGFloat = 0

    var body: some View {
        ScrollView {
            Text("hi")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
        .offset(y: offsetY)
        .background(.mint)
        .onTapGesture {
            self.offsetY = self.offsetY == 0 ? -300 : 0
        }
    }
}

#Preview {
    ContentView()
}
