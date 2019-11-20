//
//  DetailViewController.swift
//  Comcast
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailDescLabel: UILabel!
    
    //Easy to reference identifier for use in other ViewControllers
    static let identifier = "DetailViewController"
    
    var character: Character? {
        didSet {
            setupView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupView() {
        loadViewIfNeeded()
        detailImg.layer.borderWidth = 0.5
        detailImg.layer.backgroundColor = UIColor.lightGray.cgColor
        detailImg.layer.borderColor = UIColor.black.cgColor
        detailImg.layer.masksToBounds = false
        detailImg.layer.cornerRadius = detailImg.frame.height / 2
        detailImg.clipsToBounds = true
        detailImg.contentMode = .scaleAspectFit
        
        guard let currentCharacter = character else { return }
        currentCharacter.getImg() { [weak self] img in
            self?.detailImg.image = img
        }
        
        detailNameLabel.text = currentCharacter.getName()
        detailDescLabel.text = currentCharacter.getDesc()
    }
}

extension DetailViewController: DetailDelegate {
    func update(_ newCharacter: Character) {
        DispatchQueue.main.async {
            self.character = newCharacter
        }
    }
}
