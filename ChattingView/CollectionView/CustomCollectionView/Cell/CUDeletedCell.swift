//
//  CUDeletedCell.swift
//  ChattingView
//
//  Created by Gab on 3/10/25.
//

import SwiftUI

struct CUDeletedCell: View {
    var body: some View {
        Text("삭제된 메시지.")
            .font(.headline)
            .foregroundStyle(.gray)
    }
}

#Preview {
    CUDeletedCell()
}
