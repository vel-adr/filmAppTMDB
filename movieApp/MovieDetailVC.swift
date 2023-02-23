//
//  MovieDetailVC.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 31/01/23.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    var apiService = APIService()
    var movieCasts: [CastResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        apiService.delegate = self
        apiService.fetchData(query: "/movie/291805?api_key=04f99ab56e8a480fe907ad4fed4808aa&language=en-US")
        apiService.fetchCast(query: "/movie/291805/credits?api_key=04f99ab56e8a480fe907ad4fed4808aa&language=en-US")
    }
    
    private func setupViews() {
        view.addSubview(itemImage)
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addArrangedSubview(titleStack)
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(itemInfoStackView)
        itemInfoStackView.addArrangedSubview(releaseDateLabel)
        itemInfoStackView.addArrangedSubview(stackSeparatorLabel1)
        itemInfoStackView.addArrangedSubview(genreLabel)
        itemInfoStackView.addArrangedSubview(stackSeparatorLabel2)
        itemInfoStackView.addArrangedSubview(durationLabel)

        containerView.addArrangedSubview(overviewLabel)
        
        containerView.addArrangedSubview(castStack)
        castStack.addArrangedSubview(castLabel)
        castStack.addArrangedSubview(castCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: view.topAnchor),
            itemImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            itemImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            itemImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: itemImage.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),

            castCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            castCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            castCollectionView.heightAnchor.constraint(equalTo: castCollectionView.widthAnchor, multiplier: 0.65)
        ])
    }
    
    
    //Elements
    lazy var itemImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.image = UIImage(named: "tes")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    lazy var containerView: UIStackView = {
        let cv = UIStackView()
        cv.axis = .vertical
        cv.spacing = 16
        cv.alignment = .leading
        cv.distribution = .fill
        cv.isLayoutMarginsRelativeArrangement = true
        cv.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    lazy var titleStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var itemInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .firstBaseline
        stack.spacing = 4
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "xxh xxm"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Genre"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "dd/mm/yyyy"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var stackSeparatorLabel1: UILabel = {
        let label = UILabel()
        label.text = "\u{2022}"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var stackSeparatorLabel2: UILabel = {
        let label = UILabel()
        label.text = "\u{2022}"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var castStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var castLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var castCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
}

extension MovieDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, APIServiceDelegate {
    func didUpdateCast(casts: [CastResponse]) {
        DispatchQueue.main.async {
            self.movieCasts = casts
            self.castCollectionView.reloadData()
        }
    }
    
    func didUpdateMovie(movie: MovieDetailModel) {
        let durationHour = movie.duration / 60
        let durationMinute = movie.duration % 60
        let durationString = "\(durationHour)h \(durationMinute)m"
        
        DispatchQueue.main.async {
            self.itemImage.load(from: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")
            self.titleLabel.text = movie.title
            self.releaseDateLabel.text = movie.releaseDate
            self.genreLabel.text = movie.genre
            self.durationLabel.text = durationString
            self.overviewLabel.text = movie.overview
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCasts.count >= 10 ? 10 : movieCasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CastCollectionViewCell {
            cell.castImage.load(from: "https://image.tmdb.org/t/p/w500\(movieCasts[indexPath.row].profile_path ?? "")")
            cell.castNameLabel.text = movieCasts[indexPath.row].name
            cell.characterNameLabel.text = movieCasts[indexPath.row].character
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.7, height: collectionView.frame.width/1.75)
    }
}
