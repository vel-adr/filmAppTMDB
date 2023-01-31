//
//  ViewController.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 30/01/23.
//

import UIKit

class FirstScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupSubViews()
    }
    
    private func setupSubViews() {
        setupPopularLabel()
        setupPopularCollectionView()
        setupTrendingLabel()
        setupTrendingCollectionView()
    }
    
    lazy private var popularCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "movieCell")

        return collectionView
    }()
    
    lazy private var trendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "movieCell")

        return collectionView
    }()
    
    lazy private var popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular Movies"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    lazy private var trendingLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending This Week"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private func setupPopularCollectionView() {
        view.addSubview(popularCollectionView)
        
        popularCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popularCollectionView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 8),
            popularCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            popularCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            popularCollectionView.heightAnchor.constraint(equalTo: popularCollectionView.widthAnchor, multiplier: 0.58)
        ])
    }
    
    private func setupTrendingCollectionView() {
        view.addSubview(trendingCollectionView)
        
        trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trendingCollectionView.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor, constant: 8),
            trendingCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            trendingCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            trendingCollectionView.heightAnchor.constraint(equalTo: popularCollectionView.widthAnchor, multiplier: 0.58)
        ])
    }
    
    private func setupPopularLabel() {
        view.addSubview(popularLabel)
        
        popularLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popularLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            popularLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupTrendingLabel() {
        view.addSubview(trendingLabel)
        
        trendingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trendingLabel.topAnchor.constraint(equalTo: popularCollectionView.bottomAnchor, constant: 28),
            trendingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
}

extension FirstScreenVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        cell?.imageView.image = UIImage(named: "tes")
        
        return cell ?? UICollectionViewCell()
    }
}