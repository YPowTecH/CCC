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
}

class Album: Decodable {
    let id: String?
    let name: String?
    let img: String?
    
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

