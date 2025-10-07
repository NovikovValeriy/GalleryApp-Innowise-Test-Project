//
//  GetSavedPhotosUseCase.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

protocol GetSavedPhotosUseCase: AnyObject {
    func execute(completion: @escaping (Result<[Photo], Error>) -> Void)
}

final class GetSavedPhotosUseCaseImpl: GetSavedPhotosUseCase {
    private let repository: SavedPhotoRepository
    init(repository: SavedPhotoRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping (Result<[Photo], Error>) -> Void) {
        repository.fetchSavedPhotos(completion: completion)
    }
}
