//
//  ViewController.swift
//  Comcast
//
//  Created by Chris Sonet on 11/14/19.
//  Copyright © 2019 Chris. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)

    //Dynamically reload UITableView if the viewModel is changed
    var viewModel = ViewModel() {
        didSet {
            if let _ = viewModel.error {
                // do something with the error
                self.showAlert("oops")
            }
            else if viewModel.characters.isEmpty {
                self.showAlert("no data")
            }
            else {
                self.mainTableView.reloadData()
            }
        }
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        //----------------------------
        //Search Bar
        //----------------------------
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        //searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        //----------------------------
        
        //----------------------------
        //Register Cells for Table
        //----------------------------
        mainTableView.register(UINib(nibName: CharacterTableCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: CharacterTableCell.identifier)
        //----------------------------
        
        //----------------------------
        //Table Styling
        //----------------------------
        mainTableView.tableFooterView = UIView(frame: .zero)
        mainTableView.sectionIndexColor = UIColor.red
        //----------------------------
        
        //----------------------------
        //Notification & Delegates
        //----------------------------
        viewModel.charactersDelegate = self
        //----------------------------
        
        viewModel.getCharacters()
    }
}

//----------------------------
//Search Bar Extension
//----------------------------
extension MainViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let search = searchController.searchBar.text else { return }
        viewModel.filter(characters: search)
    }
    
    /*
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = searchController.searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        mainTableView.setContentOffset(.zero, animated: false)
        
        //viewModel.getSearch(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //viewModel.getSearch()
    }*/
}
//----------------------------

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ? 1 : viewModel.orderedCharacters.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ?
            viewModel.filteredCharacters.count : viewModel.getCharactersAt(section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableCell.identifier, for: indexPath) as! CharacterTableCell
        
        let characaters = isFiltering ?
            viewModel.filteredCharacters : viewModel.getCharactersAt(indexPath.section)
        let character = characaters[indexPath.row]
        cell.character = character
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let keys = viewModel.orderedCharacters.keys.sorted(by: {$0 < $1})
        return isFiltering ? "Characters" : keys[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        let keys = viewModel.orderedCharacters.keys.sorted(by: {$0 < $1})
        return isFiltering ? nil : keys
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let characters = isFiltering ?
            viewModel.filteredCharacters : viewModel.getCharactersAt(indexPath.section)
        let character = characters[indexPath.row]
        
        viewModel.currentCharacter = character//viewModel.characters[indexPath.row]
        goToDetail(with: viewModel)
    }
}

extension MainViewController {
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
extension MainViewController: CharactersDelegate {
    func charactersUpdate() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}
//----------------------------
