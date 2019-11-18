//
//  CharacterTableCell.swift
//  Comcast
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit

class CharacterTableCell: UITableViewCell {
    
    @IBOutlet weak var characterNameLabel: UILabel!
    
    //Easy to reference identifier for use in other ViewControllers
    static let identifier = "CharacterTableCell"
    
    var character: Character! {
        didSet {
            characterNameLabel.text = character.getName()
        }
    }
}
