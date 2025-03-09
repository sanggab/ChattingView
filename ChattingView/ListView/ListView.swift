//
//  ListView.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

struct ListView: UIViewRepresentable {
    
    @ObservedObject var viewModel: ListViewModel
    
    func makeUIView(context: Context) -> some UITableView {
        let tableView: UITableView = .init()
        tableView.dataSource = context.coordinator
        tableView.delegate = context.coordinator
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "chatcell")
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        return tableView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> ListViewCoordinator {
        ListViewCoordinator(viewModel: viewModel)
    }
}




