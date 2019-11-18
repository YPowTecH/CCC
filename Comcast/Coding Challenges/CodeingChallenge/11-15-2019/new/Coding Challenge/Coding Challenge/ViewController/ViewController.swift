//
//  ViewController.swift
//  Coding Challenge
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    
    //Dynamically reload listTableView if the viewModel is changed
    var viewModel = ViewModel() {
        didSet {
            if let _ = viewModel.error {
                // do something with the error
                self.showAlert("oops")
            }
            else if viewModel.albums.isEmpty {
                self.showAlert("no data")
            }
            else {
                self.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        setupStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupStyle() {
        safeArea = view.layoutMarginsGuide
        
        //----------------------------
        //Create a Table
        //----------------------------
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.backgroundColor = .lightGray
        tableView.dataSource = self
        tableView.delegate = self
        //----------------------------
    }
    
    func setupView() {
        
        //----------------------------
        //Notification & Delegates
        //----------------------------
        viewModel.albumsDelegate = self
        //----------------------------
        
        viewModel.getAlbums()
        
        //----------------------------
        //Register Cells for Table
        //----------------------------
        tableView.register(AlbumTableCell.self, forCellReuseIdentifier: AlbumTableCell.identifier)
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //----------------------------
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableCell.identifier, for: indexPath) as! AlbumTableCell
        cell.backgroundColor = .lightGray
        cell.album = viewModel.albums[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.currentAlbum = viewModel.albums[indexPath.row]
        goToDetails(with: viewModel)
    }
}

extension ViewController {
    //If the view receives an error message we have to display that
    //  to the user in a useful way
    //  they can either retry the connection or cancel the opperation
    func showAlert(_ message: String) {
        //take the message that was passed to the function
        //  and use that as the text for the error
        let alert = UIAlertController(title: message, message: nil,
                                      preferredStyle: .alert)
        //retry button to attempt another get request from the url
        let retry = UIAlertAction(title: "RETRY", style: .default) { (_) in
            //self.viewModel.get()
        }
        
        //cancel button to stop trying to get the data for another 2 seconds
        //  should be longer probably but for testing purposes its 2 seconds
        let cancel = UIAlertAction(title: "CANCEL", style: .default) { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                //self.viewModel.getPlaceholders()
            })
        }
        
        //add both the buttons to the alert
        alert.addAction(retry)
        alert.addAction(cancel)
        
        //show the alert
        self.present(alert, animated: true)
    }
}

//----------------------------
//Property observers delegates
//----------------------------
extension ViewController: AlbumsDelegate {
    func albumsUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
//----------------------------
