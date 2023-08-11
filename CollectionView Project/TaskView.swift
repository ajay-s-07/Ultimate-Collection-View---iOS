//
//  FullScreenView.swift
//  CollectionView Project
//
//  Created by Ajay Sarkate on 08/08/23.
//

import UIKit

class TaskView: UIView {
    let title = UILabel()
    let imageView = UIImageView()
    let desc = UILabel()
    let text = UITextView()
    let button = UIButton()
    
    var heightConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint!
    
    var closeHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        topConstraint.isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        heightConstraint = imageView.heightAnchor.constraint(equalToConstant: 300)
        heightConstraint.isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        title.text = "Hello"
        title.font = .boldSystemFont(ofSize: 48)
        title.textColor = .gray
        
        imageView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: imageView.topAnchor,constant:  20).isActive = true
        title.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20).isActive = true
        
        desc.text = "Description"
        desc.font = .boldSystemFont(ofSize: 32)
        
        addSubview(desc)
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        desc.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        desc.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
//        desc.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        text.text = "Announced in 2014, the Swift programming language has quickly become one of the fastest growing languages in history. Swift makes it easy to write software that is incredibly fast and safe by design. Our goals for Swift are ambitious: we want to make programming simple things easy, and difficult things possible."
        text.font = .systemFont(ofSize: 24)
        text.isUserInteractionEnabled = false
        
        addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.topAnchor.constraint(equalTo: desc.bottomAnchor).isActive = true
        text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        text.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        button.tintColor = .gray
        button.alpha = 0.9
//        button.layer.cornerRadius = 25
        button.setImage(UIImage(systemName: "x.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50)), for: .normal)
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 330).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
    }
    
    @objc func handleButton(button: UIButton) {
        
        if let action = closeHandler {
            action()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
