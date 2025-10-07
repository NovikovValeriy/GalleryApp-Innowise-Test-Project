//
//  DeletePhotoUseCase.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

protocol DeletePhotoUseCase: AnyObject {
    func execute(id: String, completion: @escaping (Result<Void, Error>) -> Void)
}

final class DeletePhotoUseCaseImpl: DeletePhotoUseCase {
    private let repository: SavedPhotoRepository
    init(repository: SavedPhotoRepository) {
        self.repository = repository
    }

    func execute(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.deletePhoto(with: id, completion: completion)
    }
}
