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
    var filterPokemon = [Pokemon]()
    var inSearchMode = false
    var searchBar: UISearchBar!
    
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
        title = "Explore"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .mainRed()

        configureSearchBarButton()

    }
    
    func configureCollectionView() {
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: identifier)

        view.addSubview(visualEffect)
        visualEffect.fillSuperview()
        visualEffect.alpha = 0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        visualEffect.addGestureRecognizer(gesture)
    }
    
    func showPokemonInfoController(withPokemon pokemon: Pokemon) {
        let controller = PokemonDetailView()
        controller.pokemon = pokemon
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func dimissInfoView(pokemon: Pokemon?) {
        UIView.animate(withDuration: 0.5) {
            self.visualEffect.alpha = 0
            self.infoView.alpha = 0
            self.infoView.transform = .identity
            self.infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        } completion: { _ in
            self.infoView.removeFromSuperview()
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            guard let pokemon = pokemon else { return }
            self.showPokemonInfoController(withPokemon: pokemon)
        }
    }
    
    func configureSearchBar(shouldShow: Bool) {
        
        if shouldShow {
            searchBar = UISearchBar()
            searchBar.delegate = self
            searchBar.sizeToFit()
            searchBar.showsCancelButton = true
            searchBar.becomeFirstResponder()
            searchBar.tintColor = .mainRed()
            
            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchBar
        } else {
            navigationItem.titleView = nil
            configureSearchBarButton()
            inSearchMode = false
            collectionView.reloadData()
        }
    }
    
    func configureSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(handleSearch))

    }
    
    //MARK: - Actions
    
    @objc func handleSearch() {
        configureSearchBar(shouldShow: true)
    }
    
    @objc func handleDismiss() {
        dimissInfoView(pokemon: nil)
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
        return inSearchMode ? filterPokemon.count : pokemon.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PokedexCell
        
        cell.pokemon = inSearchMode ? filterPokemon[indexPath.row] : pokemon[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke = inSearchMode ? filterPokemon[indexPath.row] : pokemon[indexPath.row]
        
        var pokemonEvoArray = [Pokemon]()
        
        if let evoChain = poke.evolutionChain {
            
            let evolutionChain = EvolutionChain(evolutionArray: evoChain)
            let evoIds = evolutionChain.evolutionIds
            
            evoIds.forEach { (id) in
                pokemonEvoArray.append(pokemon[id - 1])
            }
            poke.evoArray = pokemonEvoArray
        }
        showPokemonInfoController(withPokemon: poke)
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

//MARK: - PokedexCellDelegate

extension PokedexController: PokedexCellDelegate {
    
    func presentInfoView(withPokemon pokemon: Pokemon) {
        
        configureSearchBar(shouldShow: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
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

//MARK: - infoViewDelegate

extension PokedexController: infoViewDelegate {
    func dismissInfoView(withPokemon pokemon: Pokemon?) {
        dimissInfoView(pokemon: pokemon)

    }
}

//MARK: - UISearchBarDelegate

extension PokedexController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        configureSearchBar(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            filterPokemon = pokemon.filter({ $0.name?.range(of: searchText.lowercased()) != nil })
            
            collectionView.reloadData()
        }
    }
}
