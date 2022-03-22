//
//  BottomControllerStackView.swift
//  PokeDex
//
//  Created by John Padilla on 3/21/22.
//

import UIKit

class BottomControllerStackView: UIStackView {
    
    //MARK: - Properties
    
    let refreshButton = UIButton(type: .system)
    let dislikeButton = UIButton(type: .system)
    let likeButton = UIButton(type: .system)
    
    //MARK: - Lifecyc
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        refreshButton.setImage(UIImage(systemName: "arrow.counterclockwise")?.withRenderingMode(.alwaysOriginal), for: .normal)
        dislikeButton.setImage(UIImage(systemName: "x.circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        likeButton.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        [UIView(), dislikeButton, refreshButton, likeButton, UIView()].forEach { view in
            addArrangedSubview(view)
        }
        
        distribution = .equalCentering
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)

    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
