//
//  MainView.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        ListView(viewModel: viewModel)
    }
}

#Preview {
    MainView()
}
