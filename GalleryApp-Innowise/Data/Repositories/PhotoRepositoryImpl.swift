//
//  PhotoRepositoryImpl.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import Foundation

class PhotoRepositoryImpl: PhotoRepository {
    let unsplashAPIDataSource: UnsplashAPIDataSource
    
    init(unsplashAPIDataSource: UnsplashAPIDataSource) {
        self.unsplashAPIDataSource = unsplashAPIDataSource
    }
    
    func getFeedPhotos(page: Int, perPage: Int, completion: @escaping (Result<[Photo], any Error>) -> Void) {
        self.unsplashAPIDataSource.fetchFeedPhotos(page: page, perPage: perPage) { result in
            switch result {
            case .success(let photos):
                let mappedPhotos = photos.map { $0.toDomainModel() }
                completion(.success(mappedPhotos))
            case .failure:
                return
            }
        }
    }
    
    func downloadPhoto(url: String, completion: @escaping (Result<Data, any Error>) -> Void) {
        self.unsplashAPIDataSource.downloadPhoto(url: url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure:
                return
            }
        }
    }
}
