//
//  MovieDetailVC.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 31/01/23.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
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
            itemImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
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
        img.contentMode = .scaleAspectFill
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
        label.text = "Lorem Ipsum Dolor Sit Amet"
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
        label.text = "2h 19m"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Drama, Thriller, Comedy"
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
        label.text = "Queen Ramonda, Shuri, M’Baku, Okoye and the Dora Milaje fight to protect their nation from intervening world powers in the wake of King T’Challa’s death. As the Wakandans strive to embrace their next chapter, the heroes must band together with the help of War Dog Nakia and Everett Ross and forge a new path for the kingdom of Wakanda."
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

extension MovieDetailVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CastCollectionViewCell {
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.7, height: collectionView.frame.width/1.75)
    }
}
