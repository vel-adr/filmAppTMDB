//
//  MovieDetailVC.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 31/01/23.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    var movieId: Int? = nil
    var posterPath: String? = nil
    var movieTitle: String? = nil
    
    let api = APIService()
    var movieCasts: [CastResponse] = []
    var isFavorite: Bool {
        return APIService.UserData.favoriteMovies.contains(where: { $0.id == movieId })
    }
    var isWatchlist: Bool {
        return APIService.UserData.watchlistMovies.contains(where: { $0.id == movieId })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        api.delegate = self
        api.fetchMovieDetail(movieID: movieId ?? 0)
        api.fetchCast(movieID: movieId ?? 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addToFavoriteButton.setImage(UIImage(systemName: isFavorite ? "heart.fill" : "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        addToFavoriteButton.configuration?.attributedSubtitle = getSubtitleWithAttribute(text: isFavorite ? "Remove from Favorite" : "Add to Favorite")
        
        watchlistButton.setImage(UIImage(systemName: self.isWatchlist ? "bookmark.fill" : "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        watchlistButton.configuration?.attributedSubtitle = getSubtitleWithAttribute(text: isWatchlist ? "Remove from Watchlist" : "Add to Watchlist")
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        containerView.addArrangedSubview(itemImage)
        containerView.addArrangedSubview(titleStack)
        titleStack.addArrangedSubview(titleLabel)
        titleStack.addArrangedSubview(itemInfoStackView)
        itemInfoStackView.addArrangedSubview(releaseDateLabel)
        itemInfoStackView.addArrangedSubview(stackSeparatorLabel1)
        itemInfoStackView.addArrangedSubview(genreLabel)
        itemInfoStackView.addArrangedSubview(stackSeparatorLabel2)
        itemInfoStackView.addArrangedSubview(durationLabel)
        
        containerView.addArrangedSubview(buttonStack)
        buttonStack.addArrangedSubview(addToFavoriteButton)
        buttonStack.addArrangedSubview(watchlistButton)

        containerView.addArrangedSubview(overviewLabel)
        
        containerView.addArrangedSubview(castStack)
        castStack.addArrangedSubview(castLabel)
        castStack.addArrangedSubview(castCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),

            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            
            itemImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),

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
        cv.alignment = .fill
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
    
    lazy var buttonStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 16
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var addToFavoriteButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.buttonSize = .large
        config.attributedSubtitle = getSubtitleWithAttribute(text: isFavorite ? "Remove from Favorite" : "Add to Favorite")
        config.titleAlignment = .center
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .systemGray
        config.image = UIImage(systemName: isFavorite ? "heart.fill" : "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        config.imagePlacement = .top
        config.imagePadding = 8
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(hierarchicalColor: .systemPink)
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var watchlistButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.buttonSize = .large
        
        config.attributedSubtitle = getSubtitleWithAttribute(text: isWatchlist ? "Remove from Watchlist" : "Add to Watchlist")
        config.titleAlignment = .center
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .systemGray
        config.image = UIImage(systemName: isWatchlist ? "bookmark.fill" : "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        config.imagePlacement = .top
        config.imagePadding = 8
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(hierarchicalColor: .systemYellow)
        
        let btn = UIButton(configuration: config)
        btn.addTarget(self, action: #selector(watchlistButtonTapped), for: .touchUpInside)
        
        return btn
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
        
        posterPath = movie.poster_path
        movieTitle = movie.title
        
        DispatchQueue.main.async {
            self.itemImage.load(from: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")
            self.titleLabel.text = movie.title
            self.releaseDateLabel.text = movie.releaseDate
            self.genreLabel.text = movie.genre
            self.durationLabel.text = durationString
            self.overviewLabel.text = movie.overview
        }
    }
    
    private func getSubtitleWithAttribute(text: String) -> AttributedString {
        var subtitleAttributeContainer = AttributeContainer()
        subtitleAttributeContainer.font = UIFont.systemFont(ofSize: 12)
        
        return AttributedString(text, attributes: subtitleAttributeContainer)
    }
    
    @objc func favoriteButtonTapped() {
        if APIService.Auth.User == nil {
            tabBarController?.selectedIndex = 2
        } else {
            guard let movieId = movieId else { return }
            api.addToFavorite(movieId: movieId, isFavorite: !isFavorite, completionHandler: handleAddToFavorite(success:error:))
        }
    }
    
    @objc func watchlistButtonTapped() {
        if APIService.Auth.User == nil {
            tabBarController?.selectedIndex = 2
        } else {
            guard let movieId = movieId else { return }
            api.addToWatchlist(movieId: movieId, isWatchlist: !isWatchlist, completionHandler: handleAddToWatchlist(success:error:))
        }
    }
    
    private func handleAddToFavorite(success: Bool, error: Error?) {
        if success {
            if isFavorite {
                APIService.UserData.favoriteMovies = APIService.UserData.favoriteMovies.filter({ $0.id != movieId })
            } else {
                guard let movieId = movieId, let movieTitle = movieTitle else { return }
                APIService.UserData.favoriteMovies.append(SearchResult(id: movieId, posterPath: posterPath, title: movieTitle))
            }
            
            DispatchQueue.main.async {
                self.addToFavoriteButton.setImage(UIImage(systemName: self.isFavorite ? "heart.fill" : "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
                self.addToFavoriteButton.configuration?.attributedSubtitle = self.getSubtitleWithAttribute(text: self.isFavorite ? "Remove from Favorite" : "Add to Favorite")
            }
        } else {
            print(error?.localizedDescription ?? "Failed adding movies to favorite list. Please try again")
        }
    }
    
    private func handleAddToWatchlist(success: Bool, error: Error?) {
        if success {
            if isWatchlist {
                APIService.UserData.watchlistMovies = APIService.UserData.watchlistMovies.filter({ $0.id != movieId })
            } else {
                guard let movieId = movieId, let movieTitle = movieTitle else { return }
                APIService.UserData.watchlistMovies.append(SearchResult(id: movieId, posterPath: posterPath, title: movieTitle))
            }
            
            DispatchQueue.main.async {
                self.watchlistButton.setImage(UIImage(systemName: self.isWatchlist ? "bookmark.fill" : "bookmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
                self.watchlistButton.configuration?.attributedSubtitle = self.getSubtitleWithAttribute(text: self.isWatchlist ? "Remove from Watchlist" : "Add to Watchlist")
            }
        } else {
            print(error?.localizedDescription ?? "Failed adding movies to watchlist. Please try again")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCasts.count >= 10 ? 10 : movieCasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CastCollectionViewCell {
            cell.castImage.load(from: "https://image.tmdb.org/t/p/w500\(movieCasts[indexPath.row].profilePath ?? "")")
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
