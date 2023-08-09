//
//  SampleController.swift
//  Sample2
//
//  Created by Ajay Sarkate on 25/07/23.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var tags = [Tag]() {
        didSet {
            if tags.count != 0 {
                DispatchQueue.main.async {
                    if self.aiv.isAnimating {
                        self.aiv.stopAnimating()
                    }
                }
            }
        }
    }
    
    let id = "CollectionViewCell"
    let viewModel = ViewModel()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Tag>
    lazy var dataSource = configureDataSource()
    
    let aiv =  UIActivityIndicatorView(style: .large)
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        
        collectionView.addSubview(aiv)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        aiv.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addFullScreenView()
    }
    
    func addFullScreenView() {
        let taskView = TaskView()
        view.addSubview(taskView)
        
        taskView.translatesAutoresizingMaskIntoConstraints = false
        taskView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        taskView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        taskView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        taskView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
