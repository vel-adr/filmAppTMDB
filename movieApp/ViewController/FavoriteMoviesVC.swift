//
//  FavoriteMoviesVC.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 13/06/23.
//

import UIKit

class FavoriteMoviesVC: UIViewController {
    
    let api = APIService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moviesTableView.reloadData()
    }
    
    private func setupViews() {
        view.addSubview(moviesTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            moviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    lazy var moviesTableView: UITableView = {
        let table = UITableView()
        
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SearchResultTableViewCell.self, forCellReuseIdentifier: "movieCell")
        return table
    }()
}

extension FavoriteMoviesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return APIService.UserData.favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? SearchResultTableViewCell
        let movies = APIService.UserData.favoriteMovies
        
        if let posterPath = movies[indexPath.row].posterPath {
            let imgURL = "https://image.tmdb.org/t/p/w500\(posterPath)"
            cell?.resultImage.load(from: imgURL)
            cell?.setNeedsLayout()
        }
        cell?.resultLabel.text = movies[indexPath.row].title
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movies = APIService.UserData.favoriteMovies
        
        let destination = MovieDetailVC()
        destination.movieId = movies[indexPath.row].id
        destination.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(destination, animated: true)
    }
}
