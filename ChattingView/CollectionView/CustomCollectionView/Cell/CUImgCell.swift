//
//  CUImgCell.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI
import Kingfisher

struct CUImgCell: View {
    var url: String?
    
    var body: some View {
        KFImage(URL(string: url ?? ""))
            .resizable()
            .frame(width: 300, height: 300)
    }
}

#Preview {
    CUImgCell()
}
