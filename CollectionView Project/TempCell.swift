//
//  TempCell.swift
//  Sample2
//
//  Created by Ajay Sarkate on 26/07/23.
//

import UIKit

class TempCell: UICollectionViewCell {
    
    let name = UILabel()
    let email = UILabel()
    
    let rect = UIView()
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        rect.backgroundColor = .black
        rect.alpha = 0.5
        addSubview(rect)
        
        
        
        rect.translatesAutoresizingMaskIntoConstraints = false
        rect.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        rect.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        rect.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        rect.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        
        name.text = "Fusion Tech"
        email.text = "fusion@apple.com"
        
        name.font = .boldSystemFont(ofSize: 20)
        email.font = .systemFont(ofSize: 16)
        
        name.textColor = .white
        email.textColor = .white

        let stackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: []),
            name,
            email
        ])
        stackView.axis = .vertical
        stackView.alignment = .trailing
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        
        backgroundColor = .systemBlue
        layer.cornerRadius = 16
        clipsToBounds = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }.resume()
    }
    
}
// X68Hk72JPLJ6JzNAbU_sM5S0RzMnBN8BWSLXRCVCJts
// https://api.unsplash.com/photos/random?client_id=X68Hk72JPLJ6JzNAbU_sM5S0RzMnBN8BWSLXRCVCJts"
