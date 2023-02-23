//
//  APIService.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 01/02/23.
//

import Foundation

protocol APIServiceDelegate {
    func didUpdateMovie(movie: MovieDetailModel)
    func didUpdateCast(casts: [CastResponse])
}

protocol APIServiceGeneralMoviesDelegate {
    func didUpdatePopularMovies(movies: [Result])
}

class APIService {
    let baseURL = "https://api.themoviedb.org/3"
    var delegate: APIServiceDelegate?
    var popularDelegate: APIServiceGeneralMoviesDelegate?
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "TMDB-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'TMDB-Info.plist'.")
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'TMDB-Info.plist'.")
            }
            
            if (value.starts(with: "_")) {
                fatalError("Register for a TMDB developer account and get an API key at https://developers.themoviedb.org/3/getting-started/introduction.")
            }
            return value
        }
    }
    
    public func fetchData(query: String) {
        let urlString = baseURL + query + "&api_key=\(apiKey)"
        
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
                            
                            let movie = MovieDetailModel(id: decoded.id, poster_path: decoded.poster_path ?? "", title: decoded.title, releaseDate: decoded.release_date, genre: genre, duration: decoded.runtime ?? 0, overview: decoded.overview ?? "")
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
    
    public func fetchCast(query: String) {
        let urlString = baseURL + query + "&api_key=\(apiKey)"
        
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
                            let decoded = try JSONDecoder().decode(MovieCastResponse.self, from: data)
                            var casts: [CastResponse] = []
                            for item in decoded.cast {
                                casts.append(item)
                            }
                            self.delegate?.didUpdateCast(casts: casts)
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
    
    public func fetchPopular(query: String) {
        let urlString = baseURL + query + "&api_key=\(apiKey)"
        
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
                            let decoded = try JSONDecoder().decode(MovieResponse.self, from: data)
                            var movies: [Result] = []
                            for item in decoded.results {
                                movies.append(item)
                            }
                            
                            self.popularDelegate?.didUpdatePopularMovies(movies: movies)
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
