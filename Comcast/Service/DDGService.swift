//
//  DDGService.swift
//  Comcast
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import Foundation

enum CharactersResponse {
    case valid([Character])
    case empty
    case error(Error)
}

typealias CharactersHandler = (CharactersResponse) -> Void

let DDG = DDGService.shared

final class DDGService {
    static let shared = DDGService()
    private init() {}
    
    //-------------------
    //Get Characters
    //-------------------
    func getCharacters(completion: @escaping CharactersHandler) {
        guard let url = DDGAPI().getCharacters() else {
            completion(.empty)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (dat, _, err) in
            //shouldn't have any bad urls
            if let error = err {
                print("Bad Task: \(error.localizedDescription)")
                completion(.error(error))
                return
            }
            
            if let data = dat {
                do {
                    let characterResponse = try JSONDecoder().decode(CharacterResponse.self, from: data)
                    let characters = characterResponse.response
                    completion(.valid(characters))
                } catch let myError {
                    print("Couldn't Decode JSON: \(myError.localizedDescription)")
                    completion(.error(myError))
                    return
                }
            }
        }.resume()
    }
}
