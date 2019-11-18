//
//  DetailViewController.swift
//  Coding Challenge
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {

    //Easy to reference identifier for use in other ViewControllers
    static let identifier = "AlbumTableCell"
    
    private let detailAlbumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let detailMainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    private let detailSubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    private let detailSubLabel2: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    private let detailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go To ITunes Album Page", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.layer.borderWidth = 2
        button.layer.borderColor = button.tintColor.cgColor
        button.layer.masksToBounds = false
        return button
    }()
    
    private let detailTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadAlbumImage()
        setupView()
        setupDetailConstraints()
    }
    
    private func downloadAlbumImage() {
        viewModel.currentAlbum.getImg() { [weak self] img in
            self?.detailAlbumImage.image = img
        }
    }
    
    private func setupDetailConstraints() {
        let labelStackView = UIStackView(arrangedSubviews: [detailMainLabel, detailSubLabel])
        labelStackView.distribution = .equalSpacing
        labelStackView.alignment = .center
        labelStackView.spacing = 6
        labelStackView.axis = .vertical
         
        view.addSubviews(detailAlbumImage, labelStackView, detailButton, detailTextView, detailSubLabel2)

        detailAlbumImage.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 100, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 250))

        labelStackView.anchor(top: detailAlbumImage.bottomAnchor, leading: view.leadingAnchor, bottom: detailSubLabel2.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 15, bottom: 10, right: 15), size: .init(width: 0, height: 0))

        detailSubLabel2.anchor(top: labelStackView.bottomAnchor, leading: view.leadingAnchor, bottom: detailTextView.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 15, bottom: 10, right: 15), size: .init(width: 0, height: 0))

        detailTextView.anchor(top:detailSubLabel2.bottomAnchor, leading: view.leadingAnchor, bottom: detailButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 15, bottom: 15, right: 15), size: .init(width: 0, height: 0))


        detailButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20), size: .init(width: 0, height: 40))

    }
     
    private func setupView() {
        view.backgroundColor = .white

        detailMainLabel.text = viewModel.currentAlbum.name
        detailSubLabel.text = viewModel.currentAlbum.artist
        detailTextView.text = viewModel.currentAlbum.copyright
        detailSubLabel2.text = viewModel.currentAlbum.releaseDate

        detailButton.addTarget(self, action: #selector(goToWeb), for: .touchUpInside)
    }
     
    @objc func goToWeb() {
        guard let theUrl = viewModel.currentAlbum.url else { return }
        
        if let url = URL(string: theUrl) {
            print("URL: \(url.absoluteString)")
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }
    

}
