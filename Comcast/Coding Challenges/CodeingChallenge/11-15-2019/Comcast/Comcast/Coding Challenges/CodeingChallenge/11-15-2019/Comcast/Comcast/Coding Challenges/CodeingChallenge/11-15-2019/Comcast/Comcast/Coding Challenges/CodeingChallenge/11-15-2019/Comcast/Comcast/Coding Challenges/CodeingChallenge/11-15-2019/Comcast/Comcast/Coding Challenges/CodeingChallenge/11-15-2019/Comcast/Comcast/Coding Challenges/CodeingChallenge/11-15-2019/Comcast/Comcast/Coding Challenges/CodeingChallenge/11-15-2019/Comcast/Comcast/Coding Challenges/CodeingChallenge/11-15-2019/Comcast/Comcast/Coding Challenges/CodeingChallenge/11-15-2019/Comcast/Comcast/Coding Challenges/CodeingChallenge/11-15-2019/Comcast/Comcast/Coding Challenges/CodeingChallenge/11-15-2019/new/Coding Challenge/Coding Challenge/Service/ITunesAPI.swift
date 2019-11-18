//
//  ITunesAPI.swift
//  Coding Challenge
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import Foundation

struct ITunesAPI {
    let base = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
    
    func getAlbums() -> URL? {
        return URL(string: base)
    }
}

