//
//  ViewModel.swift
//  Comcast
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import Foundation

protocol CharactersDelegate: class {
    func charactersUpdate()
}

class ViewModel {
    
    weak var charactersDelegate: CharactersDelegate?
    
    var characters = [Character]() {
        didSet {
            orderedCharacters = order(characters)
        }
    }
    
    var orderedCharacters = [String:[Character]]() {
        didSet {
            charactersDelegate?.charactersUpdate()
        }
    }
    
    var filteredCharacters = [Character]()
    
    var currentCharacter: Character!
    
    var error: Error?
    
    func getCharacters() {
        DDG.getCharacters() { [weak self] response in
            switch response {
            case .valid(let results):
                self?.characters = results
                print("Result(s) Count: \(String(describing: self?.characters.count))")
            case .error(let err):
                self?.error = err
                fallthrough
            case .empty:
                self?.characters = []
            }
        }
    }
    
    func order(_ characters: [Character]) -> [String:[Character]] {
        
        //create an empty dictionary
        var ordered = [String:[Character]]()
        
        for character in characters {
            let first = character.getName().first!.uppercased()
            if ordered[first] == nil {
                ordered[first] = [character]
            } else {
                ordered[first]!.append(character)
            }
        }
        
        for (key, characters) in ordered {
            ordered[key] = characters.sorted(by: { (charOne, charTwo) -> Bool in
                charOne.getName() < charTwo.getName()
            })
        }
        
        return ordered
    }
    
    func getCharactersAt(_ section: Int) -> [Character] {
        //get the keys from the dict & order the keys
        let keys = orderedCharacters.keys.sorted(by: { $0 < $1})
        //get correct key for section
        let key = keys[section]
        //use the ordered keys to subscript the dictionary
        return orderedCharacters[key]!
    }
    
    func filter(characters bySearch: String) {
        //filter - the array based on a predicate
        filteredCharacters = characters.filter({
            $0.getName().lowercased().contains(bySearch.lowercased()) ||
                $0.getDesc().lowercased().contains(bySearch.lowercased())  })
        
        charactersDelegate?.charactersUpdate()
    }
}
