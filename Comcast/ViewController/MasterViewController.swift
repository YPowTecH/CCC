//
//  MasterViewController.swift
//  Comcast-wireviewer
//
//  Created by Chris Sonet on 11/19/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit

class MasterViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    //Easy to reference identifier for use in other ViewControllers
    static let identifier = "MasterViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    //I want the table to display before the detail viewcontroller
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}
