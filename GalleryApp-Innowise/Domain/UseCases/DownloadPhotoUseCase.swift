//
//  DownloadPhotoUseCase.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 5.10.25.
//

import Foundation

protocol DownloadPhotoUseCase: AnyObject {
    func execute(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class DownloadPhotoUseCaseImpl: DownloadPhotoUseCase {
    private let repository: PhotoRepository
    
    init(repository: PhotoRepository) {
        self.repository = repository
    }
    
    func execute(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        repository.downloadPhoto(url: url, completion: completion)
    }
}
