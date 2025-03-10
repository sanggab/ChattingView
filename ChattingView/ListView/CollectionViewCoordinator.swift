//
//  CollectionViewCoordinator.swift
//  ChattingView
//
//  Created by 심상갑 on 3/9/25.
//

import SwiftUI

final class CollectionViewCoordinator: NSObject {
    
}

extension CollectionViewCoordinator: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension CollectionViewCoordinator: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatcell", for: indexPath)
        
        cell.contentConfiguration = UIHostingConfiguration {
            VStack(spacing: 0) {
                TextCell(text: "채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!")
                    .background(.blue)
                
                TextCell(text: "채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!채팅셀이닷!!!")
                    .background(.blue)
                
                Rectangle()
                    .fill(.red)
                    .frame(height: 50)
            }
        }
        .minSize(width: 0, height: 0)
        .margins(.all, 0)
        
        return cell
    }
}

extension CollectionViewCoordinator {
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
}
