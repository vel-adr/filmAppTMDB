//
//  SearchResultTableViewCell.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 24/02/23.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupViews() {
        contentView.addSubview(resultImage)
        contentView.addSubview(resultLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            resultImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            resultImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            resultImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            resultImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            
            resultLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: resultImage.trailingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    lazy var resultLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 3
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    
    lazy var resultImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
}
