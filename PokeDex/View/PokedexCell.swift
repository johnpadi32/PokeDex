//
//  PokedexCell.swift
//  PokeDex
//
//  Created by John Padilla on 3/8/22.
//

import UIKit

class PokedexCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    var pokemon: Pokemon? {
        didSet {
            configure()
        }
    }
    
    let imageview: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "pikachu")
        return iv
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.textAlignment = .left
        label.text = "Picachu"
        return label
    }()
    
    let typeLabel: UILabel = {
       let label = UILabel()
        label.text = "Electric"
        label.textColor = .lightGray
        label.backgroundColor = .systemGray4
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    let backView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemGray6
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
        
        addSubview(imageview)
        imageview.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingBottom: 0, paddingRight: 3, width: 70, height: 70)
        
        addSubview(typeLabel)
        typeLabel.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 5, paddingBottom: 13, width: 75, height: 25)
    }
    
    //MARK: - Action
    
    private func configure() {
        imageview.image = pokemon?.image
        nameLabel.text = pokemon?.name
        typeLabel.text = pokemon?.type
    }
}
