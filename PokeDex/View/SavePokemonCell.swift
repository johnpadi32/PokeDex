//
//  SavePokemonCell.swift
//  PokeDex
//
//  Created by John Padilla on 3/17/22.
//

import UIKit

class SavePokemonCell: UITableViewCell {
    
    //MARK: - Properties
    
    let backView: UIView = {
       let view = UIView()
        view.backgroundColor = .mainRed()
        view.layer.cornerRadius = 15
        return view
    }()
    
    let circleView: UIView = {
       let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .white
        return view
    }()
    
    let PokemonImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "pikachu")
        return iv
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.text = "Pikachu"
        return label
    }()
    
    let typeLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .white.withAlphaComponent(0.3)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.setHeight(32)
        label.text = "Electric"
        return label
    }()
    
    let idLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.setHeight(25)
        label.text = "#001"
        return label
    }()

    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(backView)
        backView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        
        addSubview(circleView)
        circleView.setDimensions(height: 120, width: 120)
        circleView.layer.cornerRadius = 120 / 2
        circleView.centerY(inView: backView)
        circleView.anchor(right: backView.rightAnchor, paddingRight: 10)
        
        addSubview(PokemonImageView)
        PokemonImageView.anchor(bottom: bottomAnchor, right: rightAnchor, paddingBottom: 10, paddingRight: 25, width: 100, height: 100)
        
        let stack = UIStackView(arrangedSubviews: [idLabel, nameLabel])
        stack.axis = .vertical
        stack.spacing = 5
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: backView.leftAnchor, paddingTop: 10, paddingLeft: 15)
        
        addSubview(typeLabel)
        typeLabel.anchor(left: backView.leftAnchor, bottom: bottomAnchor, paddingLeft: 15, paddingBottom: 20, width: 95)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
