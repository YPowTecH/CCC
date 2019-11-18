//
//  ViewModel.swift
//  Coding Challenge
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import Foundation

protocol AlbumsDelegate: class {
    func albumsUpdate()
}

class ViewModel {
    
    weak var albumsDelegate: AlbumsDelegate?
    //All the articles
    var albums = [Album]() {
        didSet {
            albumsDelegate?.albumsUpdate()
        }
    }
    
    var currentAlbum: Album!
    
    var error: Error?
    
    func getAlbums() {
        itunes.getAlbums() { [weak self] response in
            switch response {
            case .valid(let results):
                self?.albums = results
                print("Result(s) Count: \(String(describing: self?.albums.count))")
            case .error(let err):
                self?.error = err
                fallthrough
            case .empty:
                self?.albums = []
            }
        }
    }
}
