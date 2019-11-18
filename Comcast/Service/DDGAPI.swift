//
//  DDGAPI.swift
//  Comcast
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import Foundation

struct DDGAPI {
    #if SIMPSONS
    let base = "http://api.duckduckgo.com/?q=simpsons+characters&format=json"
    #else
    let base = "http://api.duckduckgo.com/?q=the+wire+characters&format=json"
    #endif
    
    
    func getCharacters() -> URL? {
        return URL(string: base)
    }
}
