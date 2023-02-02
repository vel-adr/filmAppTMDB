//
//  APIService.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 01/02/23.
//

import Foundation

protocol APIServiceDelegate {
    func didUpdateMovie(movie: MovieDetailModel)
}

class APIService {
    let baseURL = "https://api.themoviedb.org/3"
    var delegate: APIServiceDelegate?
    
    public func fetchData(query: String) {
        let urlString = baseURL + query
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error fetching data. \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    DispatchQueue.main.async {
                        do {
                            let decoded = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
                            lazy var genre: String = {
                                var str = ""
                                for item in decoded.genres {
                                    str.append("\(item.name), ")
                                }
                                
                                return String(str.dropLast(2))
                            }()
                            
                            let movie = MovieDetailModel(id: decoded.id, poster_path: decoded.poster_path ?? "", title: decoded.title, releaseDate: decoded.release_date, genre: genre, duration: "\(decoded.runtime ?? 0)", overview: decoded.overview ?? "")
                            self.delegate?.didUpdateMovie(movie: movie)
                        }
                        catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
