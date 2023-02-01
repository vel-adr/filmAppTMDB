//
//  CastCollectionViewCell.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 01/02/23.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Setup element
    private func setupViews() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowRadius = 2.5
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.1)

        contentView.addSubview(bgView)
        bgView.addSubview(castImage)
        bgView.addSubview(castNameLabel)
        bgView.addSubview(characterNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bgView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bgView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            castImage.topAnchor.constraint(equalTo: bgView.topAnchor),
            castImage.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            castImage.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            castImage.heightAnchor.constraint(equalTo: bgView.heightAnchor, multiplier: 0.5),

            castNameLabel.topAnchor.constraint(equalTo: castImage.bottomAnchor, constant: 8),
            castNameLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 8),
            castNameLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -8),

            characterNameLabel.topAnchor.constraint(equalTo: castNameLabel.bottomAnchor, constant: 8),
            characterNameLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 8),
            characterNameLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -8)

        ])
    }
    
    //Elements
    lazy var bgView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var castImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "tes")
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
    }()
    
    lazy var castNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.text = "Cast Name dsadsa dsa"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.font = UIFont.systemFont(ofSize: label.font.pointSize, weight: .light)
        label.text = "Character Name dsad sa dasd sa"
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
}
