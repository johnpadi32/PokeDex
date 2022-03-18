//
//  PokemonDetailView.swift
//  PokeDex
//
//  Created by John Padilla on 3/16/22.
//

import UIKit

class PokemonDetailView: UIViewController {
    
    //MARK: - Properties
    
    var pokemon: Pokemon? {
        didSet {
            configure()
        }
    }
    
    let imageBackView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "backTest")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let idLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.textColor = .lightGray
        return label
    }()
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    let typeLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.setHeight(33)
        return label
    }()
    
    let attackLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    let defenseLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    let heightLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    let weightLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    let backDescriptionView: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    let evolutionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.text = "Evolution"
        return label
    }()
    
    let firstEvoImage: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.setWidth(100)
        iv.setHeight(120)
        return iv
    }()
    
    let lineView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let secondEvoImage: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.setWidth(100)
        iv.setHeight(120)
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()

    }
    
    //MARK: - Helper
    
    func configureUI() {
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), style: .done, target: self, action: #selector(handleDownload))
        
        view.addSubview(imageBackView)
        imageBackView.fillSuperview()
        
        view.addSubview(idLabel)
        idLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingRight: 16)
        
        view.addSubview(typeLabel)
        typeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 0, paddingLeft: 16, width: 115)
        
        view.addSubview(imageView)
        imageView.setDimensions(height: 140, width: 140)
        imageView.centerX(inView: view, topAnchor: idLabel.bottomAnchor, paddingTop: 25)
        
        view.addSubview(descriptionLabel)
        descriptionLabel.anchor(top: imageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        descriptionUI()
        
        evolutionUI()
    }
    
    func descriptionUI() {
        
        view.addSubview(backDescriptionView)
        backDescriptionView.layer.cornerRadius = 14
        backDescriptionView.anchor(top: descriptionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 10, paddingRight: 10, height: 80)
        
        view.addSubview(attackLabel)
        attackLabel.anchor(top: descriptionLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 30, paddingLeft: 25)
        
        view.addSubview(defenseLabel)
        defenseLabel.anchor(top: descriptionLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 30, paddingRight: 25)
        
        view.addSubview(heightLabel)
        heightLabel.anchor(top: attackLabel.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 25)
        
        view.addSubview(weightLabel)
        weightLabel.anchor(top: defenseLabel.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingRight: 25)
        
    }
    
    func evolutionUI() {
        
        view.addSubview(evolutionLabel)
        evolutionLabel.anchor(top: backDescriptionView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 18, paddingLeft: 10, paddingRight: 10)
        

        
        let stack = UIStackView(arrangedSubviews: [firstEvoImage, secondEvoImage])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: evolutionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        
    }
    
    func configureLabel(label: UILabel, title: String, details: String) {
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(title): ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]))

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
    
    @objc func handleDownload() {
        print("Saved Pokemon")
    }
    
    func configure() {
        
        guard let pokemon = pokemon else { return }

        guard let id = pokemon.id else { return }
        guard let attack = pokemon.attack else { return }
        guard let defense = pokemon.defense else { return }
        guard let height = pokemon.height else { return }
        guard let weight = pokemon.weight else { return }

        title = pokemon.name?.capitalized
        imageView.image = pokemon.image
        idLabel.text = "#0\(id)"
        typeLabel.text = pokemon.type?.capitalized
        descriptionLabel.text = pokemon.description
        
        configureLabel(label: attackLabel, title: "Base Attack: ", details: "\(attack)")
        configureLabel(label: defenseLabel, title: "Defense: ", details: "\(defense)")
        configureLabel(label: heightLabel, title: "Height: ", details: "\(height)")
        configureLabel(label: weightLabel, title: "Weight: ", details: "\(weight)")
        
        backDescriptionView.backgroundColor =  pokeBackgroundView
        
        if let evoArray = pokemon.evoArray {
            if evoArray.count > 1 {
                firstEvoImage.image = evoArray[0].image
                secondEvoImage.image = evoArray[1].image
            } else {
                firstEvoImage.image = evoArray[0].image
            }
        }
    }
}
