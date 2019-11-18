//
//  AlbumTableCell.swift
//  Coding Challenge
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit

class AlbumTableCell: UITableViewCell {

    //Easy to reference identifier for use in other ViewControllers
    static let identifier = "AlbumTableCell"
    
    var album: Album? {
        didSet {
            albumMainLabel.text = album?.name
            albumSubLabel.text = album?.artist
            
            album?.getImg() { [weak self] img in
                self?.albumImage.image = img
            }
        }
    }
    
    private let albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let albumMainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()
    
    private let albumSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let labelStackView = UIStackView(arrangedSubviews: [albumMainLabel, albumSubLabel])
        labelStackView.distribution = .equalSpacing
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        
        let backView = UIView()
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 10
        
        backView.addSubviews(albumImage, labelStackView)
        addSubviews(backView)
        
        backView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .init(width: 0, height: 0))
        
        albumImage.anchor(top: topAnchor, leading: backView.leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 5, left: 10, bottom: 5, right: 0), size: .init(width: 70, height: 0))
        

        
        labelStackView.anchor(top: topAnchor, leading: albumImage.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 0))

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
