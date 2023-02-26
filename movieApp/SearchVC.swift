//
//  SearchVC.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 23/02/23.
//

import UIKit

class SearchVC: UIViewController {
    
    let api = APIService()
    var searchResult: [SearchResult] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.searchDelegate = self
        
        setupViews()
        setupConstraints()
        setupSearchController()
    }
    
    func setupViews() {
        view.addSubview(searchResultTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchResultTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchResultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchResultTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchResultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search a movie title"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    lazy var searchResultTableView: UITableView = {
        let table = UITableView()
        
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
}

extension SearchVC: UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource, APIServiceSearchMovieDelegate, UISearchBarDelegate {
    func didUpdateSearchResult(result: [SearchResult]) {
        DispatchQueue.main.async {
            self.searchResult = result
            self.searchResultTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchResult[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = MovieDetailVC()
        destination.movieId = searchResult[indexPath.row].id
        destination.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        if let query = searchBar.text {
            if !query.isEmpty {
                api.searchMovie(query: query.replacingOccurrences(of: " ", with: "+"))
            }
        }
    }
}
