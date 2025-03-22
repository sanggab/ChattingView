//
//  Coordinator.swift
//  InnovationChatView
//
//  Created by 심상갑 on 3/22/25.
//

import SwiftUI

import Core

final class ChatViewCoordinator<ContentView: View>: NSObject, UICollectionViewDelegate {
    
    var dataSource: UICollectionViewDiffableDataSource<ChatSection, ChatModel>!
    
    var viewBuilderClosure: () -> ContentView
    
    init(@ViewBuilder contentView: @escaping () -> ContentView) {
        print("상갑 logEvent \(#function) CUCollectionViewCoordinator")
        self.viewBuilderClosure = contentView
    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("\(#function) indexPath: \(indexPath)")
//        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatcell", for: indexPath)
//
//        cell.contentConfiguration = UIHostingConfiguration {
//            viewBuilderClosure()
//        }
//        .minSize(width: 0, height: 0)
//        .margins(.all, 0)
//
//        return cell
//    }
    
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let widthDimensions: NSCollectionLayoutDimension = .fractionalWidth(1.0)
            let heightDimension: NSCollectionLayoutDimension = .estimated(1.0)
            
            let itemLayoutSize: NSCollectionLayoutSize = .init(widthDimension: widthDimensions,
                                                               heightDimension: heightDimension)
            
            let item: NSCollectionLayoutItem = .init(layoutSize: itemLayoutSize)
            
            let groupLayoutSize: NSCollectionLayoutSize = .init(widthDimension: widthDimensions,
                                                                heightDimension: heightDimension)
            
            let group: NSCollectionLayoutGroup = .vertical(layoutSize: groupLayoutSize,
                                                           subitems: [item])
            
            let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
            
            return section
        }
    }
        
    func setDataSource(view: UICollectionView) {
        print("상갑 logEvent \(#function)")
        self.dataSource = UICollectionViewDiffableDataSource<ChatSection, ChatModel>(collectionView: view, cellProvider: { collectionView, indexPath, itemIdentifier in
            print("상갑 logEvent \(#function) indexPath: \(indexPath)")
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatcell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                self.viewBuilderClosure()
            }
            .minSize(width: 0, height: 0)
            .margins(.all, 0)
            
            return cell
        })
    }
    
    func setData(chatModel: [ChatModel]) {
        var snapShot: NSDiffableDataSourceSnapshot<ChatSection, ChatModel> = .init()
        
        snapShot.appendSections([.main])
        
        snapShot.appendItems(chatModel, toSection: .main)
        
        self.dataSource.apply(snapShot)
    }
    
    func reloadData() {
        var snapShot: NSDiffableDataSourceSnapshot<ChatSection, ChatModel> = self.dataSource.snapshot()
        snapShot.reloadItems(snapShot.itemIdentifiers)
        self.dataSource.applySnapshotUsingReloadData(snapShot)
    }
    
    func reconfigureItems() {
        var snapShot: NSDiffableDataSourceSnapshot<ChatSection, ChatModel> = self.dataSource.snapshot()
        snapShot.reconfigureItems(snapShot.itemIdentifiers)
        self.dataSource.apply(snapShot, animatingDifferences: false)
    }
}

