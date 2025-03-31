//
//  ChattingCell.swift
//  TestChatView
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import Kingfisher

struct ImageCell: View {
    var url: String?
    
    var body: some View {
        KFImage(URL(string: url ?? ""))
    }
}

struct TextCell: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
}
