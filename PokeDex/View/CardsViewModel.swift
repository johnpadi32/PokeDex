//
//  CardsViewModel.swift
//  PokeDex
//
//  Created by John Padilla on 3/23/22.
//

import UIKit

class CardsViewModel {
    
    let pokemon: Pokemon
    
    var name: String {
        pokemon.name!
    }
    
    var type: String {
        pokemon.type!
    }
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        
    }
    

}
