//
//  UIImageView+LoadFromURL.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 02/02/23.
//

import Foundation
import UIKit

extension UIImageView {
    func load(from link: String) {
        guard let url = URL(string: link) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()
        
    }
}
