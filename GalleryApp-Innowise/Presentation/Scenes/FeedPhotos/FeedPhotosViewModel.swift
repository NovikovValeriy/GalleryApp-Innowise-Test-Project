//
//  FeedPhotosViewModel.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 1.10.25.
//

import Foundation

protocol FeedPhotosViewModel: AnyObject {
    var photos: [Photo] { get }
    var savedPhotos: [Photo] { get }
    
    var onFeedPhotosUpdated: (() -> Void)? { get set }
    var onPhotoPressed: ((Int) -> Void)? { get set }
    var onSavedPhotosUpdated: (() -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    
    func getFeedPhotos()
    func getSavedPhotos()
}

class FeedPhotosViewModelImpl: FeedPhotosViewModel {
    private let getFeedPhotosUseCase: GetFeedPhotosUseCase
    private let getSavedPhotosUseCase: GetSavedPhotosUseCase
    private let errorMapper: ErrorMapper
    
    private(set) var photos: [Photo] = []
    private(set) var savedPhotos: [Photo] = []
    private var seenPhotosIDs: Set<String> = []
    private var page: Int = 0
    private let perPage: Int = 30
    
    var onFeedPhotosUpdated: (() -> Void)?
    var onPhotoPressed: ((Int) -> Void)?
    var onSavedPhotosUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    init(
        getFeedPhotosUseCase: GetFeedPhotosUseCase,
        getSavedPhotosUseCase: GetSavedPhotosUseCase,
        errorMapper: ErrorMapper
    ) {
        self.getFeedPhotosUseCase = getFeedPhotosUseCase
        self.getSavedPhotosUseCase = getSavedPhotosUseCase
        self.errorMapper = errorMapper
    }
    
    func getFeedPhotos() {
        let nextPage = self.page + 1
        getFeedPhotosUseCase.execute(page: nextPage, perPage: perPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let feedPhotos):
                let uniquePhotos = feedPhotos.filter { photo in
                    if self.seenPhotosIDs.contains(photo.id) {
                        return false
                    } else {
                        self.seenPhotosIDs.insert(photo.id)
                        return true
                    }
                }
                self.photos.append(contentsOf: uniquePhotos)
                self.page = self.page + 1
                self.onFeedPhotosUpdated?()
            case .failure(let error):
                let message = self.errorMapper.map(error)
                self.onError?(message)
            }
        }
    }
    
    func getSavedPhotos() {
        getSavedPhotosUseCase.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let savedPhotos):
                self.savedPhotos = savedPhotos
                self.onSavedPhotosUpdated?()
            case .failure(let error):
                let message = self.errorMapper.map(error)
                self.onError?(message)
            }
        }
    }
}
