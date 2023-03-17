//
//  APIService.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 01/02/23.
//

import Foundation
import Alamofire

protocol APIServiceDelegate {
    func didUpdateMovie(movie: MovieDetailModel)
    func didUpdateCast(casts: [CastResponse])
}

protocol APIServiceGeneralMoviesDelegate {
    func didUpdatePopularMovies(movies: [Result])
    func didUpdateTrendingMovies(movies: [Result])
}

protocol APIServiceSearchMovieDelegate {
    func didUpdateSearchResult(result: [SearchResult])
}

class APIService {
    private let baseURL = "https://api.themoviedb.org/3"
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
    
    var delegate: APIServiceDelegate?
    var popularDelegate: APIServiceGeneralMoviesDelegate?
    var searchDelegate: APIServiceSearchMovieDelegate?
    
    private func request<T: Codable>(path: String, decodeModel: T.Type, completion: @escaping(Swift.Result<T,Error>) -> Void) {
        guard let url = URL(string: path) else { return }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: decodeModel) { (response) in
                if let err = response.error {
                    completion(.failure(err))
                }
                
                if let data = response.value {
                    completion(.success(data))
                }
        }
    }
    
    func fetchMovieDetail(movieID: Int) {
        let path = "\(baseURL)/movie/\(movieID)?api_key=\(apiKey)&language=en-US"
        
        request(path: path, decodeModel: MovieDetailResponse.self) { [weak self] res in
            switch res {
            case .success(let decoded):
                lazy var genre: String = {
                    var str = ""
                    for item in decoded.genres {
                        str.append("\(item.name), ")
                    }
                    
                    return String(str.dropLast(2))
                }()
                let movie = MovieDetailModel(id: decoded.id, poster_path: decoded.posterPath ?? "", title: decoded.title, releaseDate: decoded.releaseDate, genre: genre, duration: decoded.runtime ?? 0, overview: decoded.overview ?? "")
                self?.delegate?.didUpdateMovie(movie: movie)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func fetchCast(movieID: Int) {
        let path = "\(baseURL)/movie/\(movieID)/credits?api_key=\(apiKey)&language=en-US"
        
        request(path: path, decodeModel: MovieCastResponse.self) { [weak self] res in
            switch res {
            case .success(let decoded):
                var casts: [CastResponse] = []
                for item in decoded.cast {
                    casts.append(item)
                }
                self?.delegate?.didUpdateCast(casts: casts)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func fetchPopular() {
        let path = baseURL + "/movie/popular?language=en-US&page=1&api_key=\(apiKey)"
        
        request(path: path, decodeModel: MovieResponse.self) { [weak self] res in
            switch res {
            case .success(let decoded):
                var movies: [Result] = []
                for item in decoded.results {
                    movies.append(item)
                }
                self?.popularDelegate?.didUpdatePopularMovies(movies: movies)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func fetchTrending() {
        let path = baseURL + "/trending/movie/week?api_key=\(apiKey)"
        
        request(path: path, decodeModel: MovieResponse.self) { [weak self] res in
            switch res {
                
            case .success(let decoded):
                var movies: [Result] = []
                for item in decoded.results {
                    movies.append(item)
                }
                self?.popularDelegate?.didUpdateTrendingMovies(movies: movies)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func searchMovie(searchQuery: String) {
        let path = baseURL + "/search/movie?query=\(searchQuery)&api_key=\(apiKey)"
        
        request(path: path, decodeModel: SearchMovieResponse.self) { [weak self] res in
            switch res {
            case .success(let decoded):
                var results: [SearchResult] = []
                for item in decoded.results {
                    results.append(item)
                }
                self?.searchDelegate?.didUpdateSearchResult(result: results)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
