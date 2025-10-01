//
//  FeedPhotosViewModel.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 1.10.25.
//

import Foundation

protocol FeedPhotosViewModel: AnyObject {
    var photos: [Photo] { get }
    
    var onFeedPhotosUpdated: (() -> Void)? { get set }
    
    func getFeedPhotos()
}

class FeedPhotosViewModelImpl: FeedPhotosViewModel {
    private let getFeedPhotosUseCase: GetFeedPhotosUseCase
    
    private(set) var photos: [Photo] = []
    private var page: Int = 0
    private let perPage: Int = 30
    
    var onFeedPhotosUpdated: (() -> Void)?
    
    var onPhotoPressed: ((Photo) -> Void)?
    
    init(getFeedPhotosUseCase: GetFeedPhotosUseCase) {
        self.getFeedPhotosUseCase = getFeedPhotosUseCase
    }
    
    func getFeedPhotos() {
        let nextPage = self.page + 1
        getFeedPhotosUseCase.execute(page: nextPage, perPage: perPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let feedPhotos):
                self.photos.append(contentsOf: feedPhotos)
                self.page = self.page + 1
                self.onFeedPhotosUpdated?()
            case .failure:
                return
            }
        }
    }
}
