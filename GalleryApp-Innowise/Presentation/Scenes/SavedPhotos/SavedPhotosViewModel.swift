//
//  SavedPhotosViewModel.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

import Foundation

protocol SavedPhotosViewModel: AnyObject {
    var photos: [Photo] { get }
    
    var onSavedPhotosUpdated: (() -> Void)? { get set }
    var onPhotoPressed: ((Int) -> Void)? { get set }
    var onError: ((String) -> Void)? { get set }
    
    func getSavedPhotos()
}

class SavedPhotosViewModelImpl: SavedPhotosViewModel {
    private let getSavedPhotosUseCase: GetSavedPhotosUseCase
    private let errorMapper: ErrorMapper
    
    private(set) var photos: [Photo] = []
    
    var onSavedPhotosUpdated: (() -> Void)?
    var onPhotoPressed: ((Int) -> Void)?
    var onError: ((String) -> Void)?
    
    init(getSavedPhotosUseCase: GetSavedPhotosUseCase, errorMapper: ErrorMapper) {
        self.getSavedPhotosUseCase = getSavedPhotosUseCase
        self.errorMapper = errorMapper
    }
    
    func getSavedPhotos() {
        getSavedPhotosUseCase.execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let savedPhotos):
                self.photos = savedPhotos
                self.onSavedPhotosUpdated?()
            case .failure(let error):
                let message = self.errorMapper.map(error)
                self.onError?(message)
            }
        }
    }
}
