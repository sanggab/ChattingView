//
//  Coordinator.swift
//  GabChatting
//
//  Created by Gab on 3/25/25.
//

import SwiftUI

final class ChattingCoordinator<ContentView: View>: NSObject, UICollectionViewDelegate {
    
    var viewBuilderClosure: () -> ContentView
    
    var dataSource: UICollectionViewDiffableDataSource<ChattingSection, DummyItemModel>!
    
    init(viewBuilderClosure: @escaping () -> ContentView) {
        self.viewBuilderClosure = viewBuilderClosure
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
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
        self.dataSource = UICollectionViewDiffableDataSource<ChattingSection, DummyItemModel>(collectionView: view, cellProvider: { collectionView, indexPath, itemIdentifier in
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
    
    func setData() {
        var snapShot: NSDiffableDataSourceSnapshot<ChattingSection, DummyItemModel> = .init()
        
        snapShot.appendSections([.main])
        
        snapShot.appendItems([.init()], toSection: .main)
        
        self.dataSource.apply(snapShot)
    }
    
    func reloadData() {
        var snapShot: NSDiffableDataSourceSnapshot<ChattingSection, DummyItemModel> = self.dataSource.snapshot()
        snapShot.reloadItems(snapShot.itemIdentifiers)
        self.dataSource.applySnapshotUsingReloadData(snapShot)
    }
    
    func reconfigureItems() {
        var snapShot: NSDiffableDataSourceSnapshot<ChattingSection, DummyItemModel> = self.dataSource.snapshot()
        snapShot.reconfigureItems(snapShot.itemIdentifiers)
        self.dataSource.apply(snapShot, animatingDifferences: false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("상갑 logEvent \(#function) contentOffset: \(scrollView.contentOffset)")
    }
}

