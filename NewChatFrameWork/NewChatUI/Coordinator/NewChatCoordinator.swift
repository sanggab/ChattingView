//
//  NewChatCoordinator.swift
//  NewChatUI
//
//  Created by Gab on 3/31/25.
//

import SwiftUI

import Core

public final class NewChatCoordinator<ContentView: View, NewChatListModel: Hashable>: NSObject, UICollectionViewDelegate {
    
    var viewBuilderClosure: (NewChatListModel) -> ContentView
    
    var dataSource: UICollectionViewDiffableDataSource<ChatSection, NewChatListModel>!
    
    public init(viewBuilderClosure: @escaping (NewChatListModel) -> ContentView) {
        self.viewBuilderClosure = viewBuilderClosure
    }
    
    public func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
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
    
    public func setDataSource(view: UICollectionView) {
        print("상갑 logEvent \(#function)")
        self.dataSource = UICollectionViewDiffableDataSource<ChatSection, NewChatListModel>(collectionView: view, cellProvider: { collectionView, indexPath, NewChatListModel in
            print("상갑 logEvent \(#function) indexPath: \(indexPath)")
            let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatcell", for: indexPath)
            
            cell.contentConfiguration = UIHostingConfiguration {
                self.viewBuilderClosure(NewChatListModel)
            }
            .minSize(width: 0, height: 0)
            .margins(.all, 0)
            
            return cell
        })
    }
    
    public func setData(item: [NewChatListModel]) {
        print("상갑 logEvent \(#function) item: \(item)")
        var snapShot: NSDiffableDataSourceSnapshot<ChatSection, NewChatListModel> = .init()
        
        snapShot.appendSections([.main])
        
        snapShot.appendItems(item, toSection: .main)
        
        self.dataSource.apply(snapShot)
    }
    
    public func appendItem(item: [NewChatListModel]) {
        print("상갑 logEvent \(#function) item \(item)")
        var snapShot = self.dataSource.snapshot()
        
        snapShot.appendItems(item, toSection: .main)
        
        self.dataSource.applySnapshotUsingReloadData(snapShot)
    }
    
    public func reloadData() {
        var snapShot: NSDiffableDataSourceSnapshot<ChatSection, NewChatListModel> = self.dataSource.snapshot()
        snapShot.reloadItems(snapShot.itemIdentifiers)
        self.dataSource.applySnapshotUsingReloadData(snapShot)
    }
    
    public func reconfigureItems() {
        var snapShot = self.dataSource.snapshot()
        snapShot.reconfigureItems(snapShot.itemIdentifiers)
        
        self.dataSource.apply(snapShot, animatingDifferences: false)
    }
    
    public func newItem(item: [NewChatListModel]) {
        var snapShot = self.dataSource.snapshot()
        let previousItem = snapShot.itemIdentifiers
        
        snapShot.deleteItems(previousItem)
        snapShot.appendItems(item)
        
        self.dataSource.apply(snapShot, animatingDifferences: false)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("상갑 logEvent \(#function) contentOffset: \(scrollView.contentOffset)")
    }
}

