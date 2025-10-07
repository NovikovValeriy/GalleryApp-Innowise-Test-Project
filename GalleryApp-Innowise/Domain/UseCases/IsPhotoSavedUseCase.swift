//
//  IsPhotoSavedUseCase.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

protocol IsPhotoSavedUseCase: AnyObject {
    func execute(id: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class IsPhotoSavedUseCaseImpl: IsPhotoSavedUseCase {
    private let repository: SavedPhotoRepository
    init(repository: SavedPhotoRepository) {
        self.repository = repository
    }

    func execute(id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.isPhotoSaved(id, completion: completion)
    }
}
