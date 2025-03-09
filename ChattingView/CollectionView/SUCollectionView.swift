//
//  SUCollectionView.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

struct SUCollectionView: View {
    @StateObject var viewModel: CollectionViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(.orange)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .topLeading) {
                    Button {
                        viewModel.action(.onAppear)
                    } label: {
                        Text("데이터 추가")
                    }
                    .padding([.top, .leading], 12)
                }
            
            ListCollectionView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    SUCollectionView()
}
