//
//  File.swift
//  PokeDex
//
//  Created by John Padilla on 3/15/22.
//

import UIKit

class SliderController: UIViewController {
    
    //MARK: - Properties
    
    let imageBackView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "backTest")
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
        
        view.backgroundColor = .white
        
        view.addSubview(imageBackView)
        imageBackView.fillSuperview()
        
        view.addSubview(dismissButton)
        dismissButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 15)
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
}
