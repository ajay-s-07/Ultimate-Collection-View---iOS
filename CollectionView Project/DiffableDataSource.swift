//
//  DiffableDataSource.swift
//  Sample2
//
//  Created by Ajay Sarkate on 31/07/23.
//


import UIKit

enum Section {
    case all
}

extension CollectionViewController {
    
    func configureDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) {collectionView,indexPath,itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.id, for: indexPath) as! TempCell
            let tag = self.tags[indexPath.item]
            cell.name.text = tag.title
            cell.collectionViewController = self
            if let source = tag.source {
                cell.loadImage(from: source.cover_photo.urls.regular)
            }
            return cell
        }
        
        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Tag>()
        snapshot.appendSections([.all])
        snapshot.appendItems(tags, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
    
}





