//
//  SampleController.swift
//  Sample2
//
//  Created by Ajay Sarkate on 25/07/23.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var tags = [Tag]()
    
    let id = "CollectionViewCell"
    let viewModel = ViewModel()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Tag>
    lazy var dataSource = configureDataSource()
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(TempCell.self, forCellWithReuseIdentifier: id)
        viewModel.loadData { tags in
            self.tags = tags.filter { tag in
                tag.source != nil
            }
            DispatchQueue.main.async {
                self.updateSnapshot()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: 250)
    }
}
