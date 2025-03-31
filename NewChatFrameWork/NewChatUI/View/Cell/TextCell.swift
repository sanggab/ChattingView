//
//  TextCell.swift
//  NewChatUI
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

public struct TextCell: View {
    public let text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(.headline)
            .foregroundStyle(.black)
    }
}
