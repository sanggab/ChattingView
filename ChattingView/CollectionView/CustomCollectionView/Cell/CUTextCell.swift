//
//  CUTextCell.swift
//  ChattingView
//
//  Created by Gab on 3/10/25.
//

import SwiftUI

struct CUTextCell: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundStyle(.black)
    }
}

#Preview {
    TextCell(text: "반갑꼬리")
}
