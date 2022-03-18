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
    
    private let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View More Info", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8662442565, green: 0.337387979, blue: 0.3372073472, alpha: 1)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleViewMoreInfo), for: .touchUpInside)
        return button
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

        let stack = UIStackView(arrangedSubviews: [idLabel, nameLabel, typeLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8

        addSubview(stack)
        stack.anchor(top: imageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 10, paddingRight: 10)
        
        addSubview(moreInfoButton)
        moreInfoButton.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0)

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
    
    @objc func handleViewMoreInfo() {
        guard let pokemon = self.pokemon else { return }

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
