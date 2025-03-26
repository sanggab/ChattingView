//
//  Background.swift
//  ChattingUtils
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

public extension ShapeStyle where Self == Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: 1
        )
    }
}
