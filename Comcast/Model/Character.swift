//
//  Character.swift
//  Comcast
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit

struct CharacterResponse: Decodable {
    let response: [Character]
    
    private enum CodingKeys: String, CodingKey {
        case response = "RelatedTopics"
    }
}

class Character: Decodable {
    let info: String?
    let icon: Icon?
    
    private enum CodingKeys: String, CodingKey {
        case info = "Text"
        case icon = "Icon"
    }
    
    func getName() -> String {
        guard let info = self.info else { return "" }
        let text = info.components(separatedBy: " - ")
        
        if text.count >= 1 {
            return text[0]
        }
        else {
            return ""
        }
    }
    
    func getDesc() -> String {
        guard let info = self.info else { return "" }
        let text = info.components(separatedBy: " - ")
        
        if text.count == 2 {
            return text[1]
        }
        else {
            return ""
        }
    }
    
    func getImg(completion: @escaping (UIImage?) -> Void) {
        guard let icon = self.icon, let img = icon.url else { return }
        
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

struct Icon: Decodable {
    let url: String?
    
    private enum CodingKeys: String, CodingKey {
        case url = "URL"
    }
}
