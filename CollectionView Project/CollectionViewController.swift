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
        
        let tag = tags[indexPath.item]
        
        guard let source = tag.source else {
            return .zero
        }
        
        
        let width = view.frame.width - 48
        let height = (source.cover_photo.height * width) / source.cover_photo.width
        
        return .init(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addFullScreenView(index: indexPath.item)
    }
    
    func addFullScreenView(index: Int) {
        let tag = tags[index]
        
        let taskView = TaskView()
        taskView.title.text = tag.title.capitalized
        loadImage(from: tag.source?.cover_photo.urls.regular ?? "", in: taskView.imageView)
        taskView.text.text = tag.source?.description
        view.addSubview(taskView)
        
        taskView.translatesAutoresizingMaskIntoConstraints = false
        taskView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        taskView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        taskView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        taskView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func loadImage(from urlString: String, in imgView: UIImageView) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imgView.image = image
                    }
                }
            }
        }.resume()
    }
}
