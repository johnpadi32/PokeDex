//
//  InfoView.swift
//  PokeDex
//
//  Created by John Padilla on 3/14/22.
//

import UIKit

protocol infoViewDelegate {
    func dismissInfoView(withPokemon pokemon: Pokemon?)
}

class InfoView: UIView {
    
    //MARK: - Properties
    
    var pokemon: Pokemon? {
        didSet {
            configure()
        }
    }
    
    var delegate: infoViewDelegate?
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let idLabel: UILabel = {
       let label = UILabel()
        label.backgroundColor = .white.withAlphaComponent(0.3)
        label.textAlignment = .center
        label.setWidth(70)
        label.setHeight(25)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        return label
    }()
    
    let typeLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    let backView: UIView = {
       let view = UIView()
        return view
    }()
    
    let circleView: UIView = {
       let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .white
        return view
    }()
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .white
        self.layer.masksToBounds = true
        
        addSubview(backView)
        backView.fillSuperview()
        
        addSubview(circleView)
        circleView.setDimensions(height: 240, width: 240)
        circleView.layer.cornerRadius = 240 / 2
        circleView.centerX(inView: self, topAnchor: topAnchor, paddingTop: 50)
        
        
        addSubview(imageView)
        imageView.setDimensions(height: 230, width: 230)
        imageView.anchor(left: leftAnchor, bottom: circleView.bottomAnchor,right: rightAnchor, paddingLeft: 50, paddingBottom: -40, paddingRight: 50)

        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 15, paddingRight: 15, width: 20, height: 20)

        let stack = UIStackView(arrangedSubviews: [idLabel, nameLabel, typeLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8

        addSubview(stack)
        stack.anchor(top: imageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 10, paddingRight: 10)
        
        //addSubview(moreInfoButton)
        //moreInfoButton.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0)

    }
    
    func configureLabel(label: UILabel, title: String, details: String) {
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(title)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        attributedText.append(NSAttributedString(string: "\(details)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))
        label.attributedText = attributedText
    }
    
    var pokeBackgroundView: UIColor {
        
        if pokemon?.type == "water" {
            return UIColor.viewBlue()
        } else if pokemon?.type == "poison" {
            return UIColor.viewGree()
        } else if pokemon?.type == "bug" {
            return UIColor.viewGree()
        } else if pokemon?.type == "flying" {
            return UIColor.viewBrown()
        } else if pokemon?.type == "fire" {
            return UIColor.viewRed()
        } else if pokemon?.type == "electric" {
            return UIColor.viewYellow()
        } else if pokemon?.type == "ground" {
            return UIColor.viewPurple()
        } else if pokemon?.type == "psychic" {
            return UIColor.viewYellow()
        } else if pokemon?.type == "fighting" {
            return UIColor.viewPurple()
        } else if pokemon?.type == "grass" {
            return UIColor.viewGree()
        } else if pokemon?.type == "fairy" {
            return UIColor.systemPink
        } else {
            return UIColor.systemGray6
        }
    }
    
    //MARK: - Actions
    
    @objc func handleDismiss() {
        delegate?.dismissInfoView(withPokemon: pokemon)
    }
    
    func configure() {
        
        guard let type = pokemon?.type else { return }
        guard let id = pokemon?.id else { return }
        
        guard let pokemon = pokemon else { return }
        imageView.image = pokemon.image
        nameLabel.text = pokemon.name?.capitalized
        
        configureLabel(label: idLabel, title: "#", details: "0\(id)")
        configureLabel(label: typeLabel, title: "Type: ", details: "\(type)")
        
        backView.backgroundColor =  pokeBackgroundView
    }
}
