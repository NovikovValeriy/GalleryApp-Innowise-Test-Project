//
//  SavePhotoUseCase.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

protocol SavePhotoUseCase: AnyObject {
    func execute(photo: Photo, completion: @escaping (Result<Void, Error>) -> Void)
}

final class SavePhotoUseCaseImpl: SavePhotoUseCase {

    private let repository: SavedPhotoRepository
    init(repository: SavedPhotoRepository) {
        self.repository = repository
    }

    func execute(photo: Photo, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.savePhoto(photo, completion: completion)
    }
}
