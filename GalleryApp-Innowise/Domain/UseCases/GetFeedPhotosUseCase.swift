//
//  GetFeedPhotosUseCase.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

protocol GetFeedPhotosUseCase {
    func execute(page: Int, perPage: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
}

class GetFeedPhotosUseCaseImpl: GetFeedPhotosUseCase {

    private let repository: PhotoRepository

    init(repository: PhotoRepository) {
        self.repository = repository
    }

    func execute(page: Int, perPage: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        repository.getCuratedPhotos(page: page, perPage: perPage) { result in
            switch result {
            case .success(let photos):
                completion(.success(photos))
            case .failure:
                break
            }
        }
    }
}
