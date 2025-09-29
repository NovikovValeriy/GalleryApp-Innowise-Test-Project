//
//  PhotoRepositoryImpl.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import Foundation

class PhotoRepositoryImpl: PhotoRepository {
    func getCuratedPhotos(page: Int, perPage: Int, completion: @escaping (Result<[Photo], any Error>) -> Void) {
        
    }
    
    func downloadPhoto(url: String, completion: @escaping (Result<Data, any Error>) -> Void) {
        
    }
}
