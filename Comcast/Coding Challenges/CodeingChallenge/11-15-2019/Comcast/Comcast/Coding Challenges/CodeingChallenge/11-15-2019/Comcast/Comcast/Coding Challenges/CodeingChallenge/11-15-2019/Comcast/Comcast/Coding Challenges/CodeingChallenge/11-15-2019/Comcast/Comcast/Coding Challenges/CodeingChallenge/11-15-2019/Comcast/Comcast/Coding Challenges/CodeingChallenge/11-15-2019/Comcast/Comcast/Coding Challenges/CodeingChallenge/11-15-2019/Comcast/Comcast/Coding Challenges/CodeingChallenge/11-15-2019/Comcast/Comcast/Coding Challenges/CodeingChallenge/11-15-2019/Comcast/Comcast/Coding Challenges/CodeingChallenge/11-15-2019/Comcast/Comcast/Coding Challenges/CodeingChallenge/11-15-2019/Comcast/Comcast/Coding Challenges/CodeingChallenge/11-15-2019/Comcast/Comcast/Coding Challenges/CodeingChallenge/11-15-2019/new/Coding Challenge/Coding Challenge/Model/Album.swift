//
//  Album.swift
//  Coding Challenge
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit

struct Albums: Decodable {
    let response: [Album]
    
    private enum CodingKeys: String, CodingKey {
        case response = "results"
    }
}

class Album: Decodable {
    let id: String?
    let name: String?
    let artist: String?
    let releaseDate: String?
    let copyright: String?
    let img: String?
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case img = "artworkUrl100"
        case id, name, releaseDate, copyright, url
    }
    
    func getImg(completion: @escaping (UIImage?) -> Void) {
        guard let img = self.img else { return }
        
        cache.downloadFrom(endpoint: img) { response in
            switch response {
            case .valid(let dat):
                completion(UIImage(data: dat))
            case .error(_):
                completion(UIImage(imageLiteralResourceName: "404s"))
            case .empty:
                completion(UIImage(imageLiteralResourceName: "404s"))
            }
        }
    }
}

