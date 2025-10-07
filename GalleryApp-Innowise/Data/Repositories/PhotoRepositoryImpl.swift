//
//  PhotoRepositoryImpl.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import Foundation

class PhotoRepositoryImpl: PhotoRepository {
    private let unsplashAPIDataSource: UnsplashAPIDataSource
    private let photoCacheDataSource: PhotoCacheDataSource
    
    init(unsplashAPIDataSource: UnsplashAPIDataSource, photoCacheDataCource: PhotoCacheDataSource) {
        self.unsplashAPIDataSource = unsplashAPIDataSource
        self.photoCacheDataSource = photoCacheDataCource
    }
    
    func getFeedPhotos(page: Int, perPage: Int, completion: @escaping (Result<[Photo], any Error>) -> Void) {
        self.unsplashAPIDataSource.fetchFeedPhotos(page: page, perPage: perPage) { result in
            switch result {
            case .success(let photos):
                let mappedPhotos = photos.map { $0.toDomainModel() }
                completion(.success(mappedPhotos))
            case .failure(let networkError):
                completion(.failure(PhotoRepositoryError.network(networkError)))
            }
        }
    }
    
    func downloadPhoto(url: String, completion: @escaping (Result<Data, any Error>) -> Void) {
        if let data = self.photoCacheDataSource.getImageData(for: url) {
            completion(.success(data))
        } else {
            self.unsplashAPIDataSource.downloadPhoto(url: url) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.photoCacheDataSource.setImageData(data: data, for: url)
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(PhotoRepositoryError.network(error)))
                }
            }
        }
    }
}
