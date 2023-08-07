//
//  TempCell.swift
//  Sample2
//
//  Created by Ajay Sarkate on 26/07/23.
//

import UIKit

class TempCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    weak var collectionViewController: CollectionViewController?
    var pan: UIPanGestureRecognizer!
    
    let name = UILabel()
    let email = UILabel()
    
    let rect = UIView()
    
    let imageView = UIImageView()
    
    let button: UIImageView = {
        let button = UIImageView()
        let confg = UIImage.SymbolConfiguration(pointSize: 24)
        button.image = UIImage(systemName: "trash.fill", withConfiguration: confg)
        button.contentMode = .center
        button.tintColor = .white
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.isUserInteractionEnabled = true
        
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
        
        addSubview(button)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleButtonAction))
        button.addGestureRecognizer(tap)
        
        backgroundColor = .systemBlue
        layer.cornerRadius = 16
        clipsToBounds = true
        
        addPanGesture()
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
    
    @objc func handleButtonAction(gesture: UITapGestureRecognizer) {
        
        showAlert()
        print("Button action working")
    }
    
    func showAlert() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
        let alert = UIAlertController(title: "Delete Item?", message: "This item will be deleted.", preferredStyle: .alert)
    
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { action in
            if let controller = self.collectionViewController {
                if let indexPath = controller.collectionView.indexPath(for: self) {
                    controller.tags.remove(at: indexPath.item)
                    controller.updateSnapshot(animatingChange: true)
                }
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(delete)
        
        if let controller = collectionViewController {
            controller.present(alert, animated: true)
        }
    }
    
    func addPanGesture() {
        pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        pan.delegate = self
        addGestureRecognizer(pan)
    }
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        guard let controller = collectionViewController else {
            return
        }
        
        guard !controller.collectionView.isDragging else {
            return
        }
        
        let translation = gesture.translation(in: gesture.view)

        switch gesture.state {
        case .began, .changed:
            
            let offset = gesture.translation(in: gesture.view)
            let angle = min(offset.x / (gesture.view?.frame.width)! * 90, 60)
            
            let transform = CGAffineTransform(translationX: translation.x, y: .zero)
//            gesture.view!.transform = transform
            
            if translation.x > 0 {
                gesture.view!.transform = transform.rotated(by: angle / 360 * .pi)
            }
            if translation.x < 0 {
                gesture.view!.transform = transform.rotated(by: angle / 360 * .pi)
            }
            
            if translation.x >= 150 || translation.x <= -150 {
                showAlert()
                gesture.state = .ended
            }
        case .ended:
            UIView.animate(withDuration: 0.36) {
                gesture.view!.transform = .identity
            }
        default:
            print("Pan default")
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if pan.state == .changed {
            return false
        }
        return true
    }
    
}
// X68Hk72JPLJ6JzNAbU_sM5S0RzMnBN8BWSLXRCVCJts
// https://api.unsplash.com/photos/random?client_id=X68Hk72JPLJ6JzNAbU_sM5S0RzMnBN8BWSLXRCVCJts"
