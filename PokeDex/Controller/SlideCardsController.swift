//
//  SlideCardsController.swift
//  PokeDex
//
//  Created by John Padilla on 3/10/22.
//

import UIKit

class SlideCardsController: UIViewController {

    
    
    //MARK: - Properties
    
    var pokemon = [Pokemon]()
    

    

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .done, target: self, action: #selector(handleDismiss))

    }
    
    //MARK: - Helpers

    
    //MARK: - Actions
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
