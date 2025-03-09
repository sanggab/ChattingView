//
//  SUCollectionView.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

struct SUCollectionView: View {
    var body: some View {
        ListCollectionView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SUCollectionView()
}
