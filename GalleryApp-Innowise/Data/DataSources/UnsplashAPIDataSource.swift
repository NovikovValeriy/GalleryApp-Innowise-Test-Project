//
//  UnsplashAPIDataSource.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import Foundation

class UnsplashAPIDataSource {
    
    private let session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        return URLSession(configuration: sessionConfig)
    }()
    
    private var components: URLComponents = {
        var comp = URLComponents()
        comp.scheme = "https"
        comp.host = "api.unsplash.com"
        return comp
    }()
    
    private func makeURLRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        let key = "Client-ID \(UnsplashApiKey.key.rawValue)"
        request.setValue(key, forHTTPHeaderField: "Authorization")
        return request
    }
    
    func fetchFeedPhotos(page: Int, perPage: Int, completion: @escaping (Result<[PhotoDTO], NetworkError>) -> Void) {
        var comp = self.components
        comp.path = "/photos"
        comp.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]
        
        guard let url = comp.url else {
            completion(.failure(.invalidURL));
            return
        }
        let req = self.makeURLRequest(url: url)
        
        
        let task = self.session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                if httpResponse.statusCode == 401 {
                    completion(.failure(.unauthorized))
                } else {
                    completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                }
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([PhotoDTO].self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
    
    func downloadPhoto(url: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = self.session.downloadTask(with: url) { localURL, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode),
                    let localURL = localURL
            else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let data = try Data(contentsOf: localURL)
                completion(.success(data))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }
        task.resume()
    }
}
