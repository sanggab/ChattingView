//
//  ListView + Coordinator.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

class ListViewCoordinator: NSObject {
    @ObservedObject var viewModel: ListViewModel
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
    }
    
}

extension ListViewCoordinator: UITableViewDelegate {
    
}

extension ListViewCoordinator: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel(\.list).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatcell", for: indexPath)
        
        
        
        return cell
    }
    
    
}
