//
//  ViewController.swift
//  PokeDex
//
//  Created by John Padilla on 3/8/22.
//

import UIKit

private let identifier = "PokedexCell"

class PokedexController: UICollectionViewController {
    
    //MARK: - Properties
    
    var pokemon = [Pokemon]()
    
    let infoView: InfoView = {
        let view = InfoView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "backTest")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let visualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureCollectionView()
        fetchPokemon()
    }

    //MARK: - Helpers
    
    func configureNavBar() {
        
        collectionView.backgroundView = imageView
        title = "Pokedex"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .mainRed()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.stack.3d.down.right"), style: .done, target: self, action: #selector(handleSlidingCards))
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(handleSearch)),
            UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: nil)
        ]
    }
    
    func configureCollectionView() {
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: identifier)

        view.addSubview(visualEffect)
        visualEffect.fillSuperview()
        visualEffect.alpha = 0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        visualEffect.addGestureRecognizer(gesture)
    }
    
    func dimissInfoView(pokemon: Pokemon?) {
        UIView.animate(withDuration: 0.5) {
            self.visualEffect.alpha = 0
            self.infoView.alpha = 0
            self.infoView.transform = .identity
            self.infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } completion: { _ in
            self.infoView.removeFromSuperview()
        }
    }
    
    //MARK: - Actions
    
    @objc func handleSearch() {
        print("Search Prokemon")
    }
    
    @objc func handleDismiss() {
        dimissInfoView(pokemon: nil)
    }
                                                           
    @objc func handleSlidingCards() {
        let controller = SlideCardsController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    //MARK: - API
    
    private func fetchPokemon() {
        APICaller.shared.fetchPokemon { (pokemon) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: - UICollectionViewDataSource

extension PokedexController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PokedexCell
        cell.delegate = self
        cell.pokemon = pokemon[indexPath.row]
        
        return cell
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension PokedexController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 20, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

extension PokedexController: PokedexCellDelegate {
    
    func presentInfoView(withPokemon pokemon: Pokemon) {
        
        view.addSubview(infoView)
        infoView.delegate = self
        infoView.pokemon = pokemon
        
        infoView.anchor(width: view.frame.width - 100, height: 550)
        infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -14).isActive = true
        
        infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        infoView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffect.alpha = 1
            self.infoView.alpha = 1
            self.infoView.transform = .identity
        }
    }
}

extension PokedexController: infoViewDelegate {
    func dismissInfoView(withPokemon pokemon: Pokemon?) {
        dimissInfoView(pokemon: pokemon)
    }
    
    
}
