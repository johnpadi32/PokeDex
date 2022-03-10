//
//  APICaller.swift
//  PokeDex
//
//  Created by John Padilla on 3/9/22.
//

import Foundation
import UIKit

struct Constants {
    static let baseURL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
}

class APICaller {
    static let shared = APICaller()
    
    //MARK: - Fetch Pokemon
    
    func fetchPokemon(completion: @escaping([Pokemon]) -> ()) {
        var pokemonArray = [Pokemon]()
        guard let url = URL(string: "\(Constants.baseURL)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                guard let resultArray = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] else { return }
                
                for (key, result) in resultArray.enumerated() {
                    if let dictionary = result as? [String: AnyObject] {
                        let pokemon = Pokemon(id: key, dictionary: dictionary)
                        
                        guard let imageUrl = pokemon.imageUrl else { return }
                        
                        self.fetchImages(withUrlString: imageUrl) { image in
                            pokemon.image = image
                            pokemonArray.append(pokemon)
                            
                            ///call pokemon in order
                            pokemonArray.sort { (poke1, poke2) -> Bool in
                                return poke1.id! < poke2.id!
                            }
                            completion(pokemonArray)
                        }
                    }
                }
            } catch {
                print("Failed to created Json with Error", error.localizedDescription)
            }
        }
        task.resume()
    }
    
    //MARK: - Fetch Images
    
    func fetchImages(withUrlString urlString: String, completion: @escaping(UIImage) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        let taks = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to fetch image with error", error.localizedDescription)
                return
            }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }
        taks.resume()
    }
}
