//
//  PokedexCell.swift
//  PokeDex
//
//  Created by John Padilla on 3/8/22.
//

import UIKit

protocol PokedexCellDelegate {
    func presentInfoView(withPokemon pokemon: Pokemon)
}

class PokedexCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var pokemon: Pokemon? {
        didSet {
            configure()
        }
    }
    
    var delegate: PokedexCellDelegate?
    
    let imageview: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let typeLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .white.withAlphaComponent(0.3)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.setHeight(25)
        return label
    }()
    
    let idLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.setHeight(25)
        return label
    }()
    
    let backView: UIView = {
       let view = UIView()
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
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        
        addSubview(backView)
        backView.fillSuperview()
        
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 2, paddingLeft: 5, paddingRight: 5, height: 40)
        
        addSubview(idLabel)
        idLabel.anchor(top: topAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 10)
        
        addSubview(imageview)
        imageview.anchor(bottom: bottomAnchor, right: rightAnchor, paddingBottom: 5, paddingRight: 10, width: 68, height: 68)
        
        addSubview(typeLabel)
        typeLabel.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 5, paddingBottom: 13, width: 75)
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressed))
        self.addGestureRecognizer(longPressGestureRecognizer)
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
    
    //MARK: - Action
    
    private func configure() {
        
        guard let id = pokemon?.id else { return }
        
        imageview.image = pokemon?.image
        nameLabel.text = pokemon?.name
        typeLabel.text = pokemon?.type?.capitalizeFirstLetter()
        idLabel.text = "#\(id)"
        
        backView.backgroundColor =  pokeBackgroundView
    }
    
    
    
    @objc func handleLongPressed(sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            guard let pokemon = pokemon else { return }
            delegate?.presentInfoView(withPokemon: pokemon)

        }
    }
}

