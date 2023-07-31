//
//  ViewController.swift
//  CollectionView Project
//
//  Created by Ajay Sarkate on 31/07/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let sampleVC = CollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let sampleView = sampleVC.view!
        
        view.addSubview(sampleView)
        addChild(sampleVC)
        sampleVC.didMove(toParent: self)
        
        sampleView.translatesAutoresizingMaskIntoConstraints = false
        sampleView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sampleView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sampleView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sampleView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }


}

