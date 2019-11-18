//
//  ViewController+Extension.swift
//  Comcast
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit

extension UIViewController {
    func goToDetail(with vm: ViewModel) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        detailVC.viewModel = vm
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
