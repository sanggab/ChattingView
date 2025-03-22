//
//  Modifier.swift
//  ChattingView
//
//  Created by Gab on 3/21/25.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: 1
        )
    }
}

extension View {
    func getSize(_ size: @escaping ((CGSize) -> Void)) -> some View {
        background {
            GeometryReader { proxy in
                Color.clear
                    .frame(width: 0, height: 0)
                    .onAppear {
                        size(proxy.size)
                    }
            }
        }
    }
}
