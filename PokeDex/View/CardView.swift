//
//  CardView.swift
//  PokeDex
//
//  Created by John Padilla on 3/21/22.
//

import UIKit

enum SwipeDirection: Int {
    case left = -1
    case right = 1
}

class CardView: UIView {
    
    //MARK: - Properties
    
    let backView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let circleView: UIView = {
       let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .white
        return view
    }()
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "pikachu")
        return iv
    }()
    
    let idLabel: UILabel = {
       let label = UILabel()
        label.backgroundColor = .white.withAlphaComponent(0.3)
        label.textAlignment = .center
        label.text = "#001"
        label.textColor = .white
        label.setWidth(70)
        label.setHeight(25)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 38, weight: .semibold)
        label.text = "Pikachu"
        return label
    }()
    
    let typeLabel: UILabel = {
       let label = UILabel()
        label.backgroundColor = .white.withAlphaComponent(0.3)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.text = "Electric"
        label.setWidth(120)
        label.setHeight(30)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()

    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureGestureRecognizer()
        
        backgroundColor = .systemBlue
        layer.cornerRadius = 35
        clipsToBounds = true
        
        addSubview(backView)
        backView.fillSuperview()
        
        addSubview(circleView)
        circleView.setDimensions(height: 240, width: 240)
        circleView.layer.cornerRadius = 240 / 2
        circleView.centerX(inView: self, topAnchor: topAnchor, paddingTop: 80)
        
        addSubview(imageView)
        imageView.setDimensions(height: 280, width: 280)
        imageView.centerX(inView: self, topAnchor: safeAreaLayoutGuide.topAnchor, paddingTop: 50)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, typeLabel, idLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12

        addSubview(stack)
        stack.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingBottom: 45, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Helpers
    
    func configureGestureRecognizer() {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGestue))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
    
    func resetCardPosition(sender: UIPanGestureRecognizer) {
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransfeorm = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransfeorm
            } else {
                self.transform = .identity
            }
        } completion: { _ in
            if shouldDismissCard {
                self.removeFromSuperview()
            }
        }
    }
    
    func panCard(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degress: CGFloat = translation.x / 20
        let angle = degress * .pi / 180
        let rotationalTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    //MARK: - Actions
    
    @objc func handlePanGestue(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations()})
        case .changed:
            panCard(sender: sender)
        case .ended:
            resetCardPosition(sender: sender)
        @unknown default:
            break
        }

    }
    
    @objc func handleChangePhoto(sender: UITapGestureRecognizer) {
        
    }
}
