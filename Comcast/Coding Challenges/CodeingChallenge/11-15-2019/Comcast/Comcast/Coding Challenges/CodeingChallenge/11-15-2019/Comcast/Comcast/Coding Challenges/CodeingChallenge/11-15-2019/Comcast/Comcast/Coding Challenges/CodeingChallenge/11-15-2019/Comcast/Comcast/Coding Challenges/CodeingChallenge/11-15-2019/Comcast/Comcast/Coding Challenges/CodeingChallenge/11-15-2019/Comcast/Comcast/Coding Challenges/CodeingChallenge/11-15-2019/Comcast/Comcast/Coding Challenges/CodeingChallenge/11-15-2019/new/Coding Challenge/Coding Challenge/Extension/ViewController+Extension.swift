//
//  ViewController+Extension.swift
//  Coding Challenge
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit

extension UIViewController {
    func goToDetails(with vm: ViewModel) {
        let detailVC = DetailViewController()
        detailVC.viewModel = vm
        
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.view.backgroundColor = .white
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
