//
//  File.swift
//  PokeDex
//
//  Created by John Padilla on 3/15/22.
//

import UIKit

class SliderController: UIViewController {
    
    //MARK: - Properties
    
    var pokemon = [Pokemon]()
    private let bottomStack = BottomControllerStackView()
    
    private var viewModels = [CardsViewModel]() {
        didSet { configureCards() }
    }
    
    private let deckView: UIView = {
       let view = UIView()
//        view.backgroundColor = .systemPink
        view.layer.cornerRadius = 5
        return view
    }()
    
    let imageBackView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "backTest")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let centerkView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "poke")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .mainRed()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
//        configureCards()
        fetchPokemon()
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    //MARK: - Helpers
    
    func configureCards() {
                
        viewModels.forEach { viewModel in
            let cardView = CardView(viewModel: viewModel)
            deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
//        let cardView1 = CardView()
//        let cardView2 = CardView()
//
//        deckView.addSubview(cardView1)
//        deckView.addSubview(cardView2)
//
//        cardView1.fillSuperview()
//        cardView2.fillSuperview()
    }
    
    func configureUI() {
        
        view.backgroundColor = .white
        navigationItem.titleView = UIImageView(image: UIImage(named: "catch"))

        
        view.addSubview(imageBackView)
        imageBackView.fillSuperview()
        
        view.addSubview(centerkView)
        centerkView.setDimensions(height: 100, width: 150)
        centerkView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10)

        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 15)
        
        let stack = UIStackView(arrangedSubviews: [deckView, bottomStack])
        stack.axis = .vertical
        
        view.addSubview(stack)
        stack.anchor(top: centerkView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 20, left: 20, bottom: 0, right: 20)
        stack.bringSubviewToFront(deckView)
    }
    
    //MARK: - Actions
    
    //MARK: - API
    
    private func fetchPokemon() {
        APICaller.shared.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                self.viewModels = pokemon.map({ CardsViewModel(pokemon: $0)})
                self.viewDidLoad()
            }
            
        }
    }
}
