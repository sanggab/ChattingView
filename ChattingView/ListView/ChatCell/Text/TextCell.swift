//
//  TextCell.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

struct TextCell: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(.gray)
    }
}

#Preview {
    TextCell(text: "채팅셀")
}
