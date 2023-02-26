//
//  SearchResultTableViewCell.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 24/02/23.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        setupConstraints()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupViews() {
        contentView.addSubview(resultLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            resultLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    lazy var resultLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
}
