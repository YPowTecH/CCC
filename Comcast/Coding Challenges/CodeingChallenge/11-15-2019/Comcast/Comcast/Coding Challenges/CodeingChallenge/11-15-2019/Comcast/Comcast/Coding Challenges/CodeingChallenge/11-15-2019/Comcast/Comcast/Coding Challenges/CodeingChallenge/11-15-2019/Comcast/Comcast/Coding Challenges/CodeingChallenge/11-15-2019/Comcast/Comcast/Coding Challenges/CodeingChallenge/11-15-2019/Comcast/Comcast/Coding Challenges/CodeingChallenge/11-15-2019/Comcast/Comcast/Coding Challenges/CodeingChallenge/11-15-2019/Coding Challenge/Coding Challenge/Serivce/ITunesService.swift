//
//  ITunesService.swift
//  Coding Challenge
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import Foundation

enum AlbumsResponse {
    case valid([Album])
    case empty
    case error(Error)
}

typealias AlbumsHandler = (AlbumsResponse) -> Void

let itunes = ITunesService.shared

final class ITunesService {
    static let shared = ITunesService()
    private init() {}

    func getAlbums(completion: @escaping AlbumsHandler) {
        guard let url = ITunesAPI().getAlbums() else {
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
                    let albumsResponse = try JSONDecoder().decode(Albums.self, from: data)
                    let albums = albumsResponse.response
                    completion(.valid(albums))
                } catch let myError {
                    print("Couldn't Decode JSON: \(myError.localizedDescription)")
                    completion(.error(myError))
                    return
                }
            }
        }.resume()
    }
}
