//
//  SavedController.swift
//  PokeDex
//
//  Created by John Padilla on 3/15/22.
//

import UIKit

private let identifier = "SavePokemonCell"

class SavedController: UITableViewController {
    
    //MARK: - Properties
    
    let imageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "backTest")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar()
        configureTableView()
    }
    
    //MARK: - Helpers
    
    func configureNavBar() {
        
        tableView.backgroundView = imageView
        title = "Saved"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        tableView.separatorStyle = .none
        tableView.register(SavePokemonCell.self, forCellReuseIdentifier: identifier)
    }
}

//MARK: - UITableViewDataSource

extension SavedController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SavePokemonCell
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension  SavedController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
