//
//  GetFeedPhotosUseCase.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

protocol GetFeedPhotosUseCase: AnyObject {
    func execute(page: Int, perPage: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
}

final class GetFeedPhotosUseCaseImpl: GetFeedPhotosUseCase {

    private let repository: PhotoRepository

    init(repository: PhotoRepository) {
        self.repository = repository
    }

    func execute(page: Int, perPage: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        repository.getFeedPhotos(page: page, perPage: perPage, completion: completion)
    }
}
