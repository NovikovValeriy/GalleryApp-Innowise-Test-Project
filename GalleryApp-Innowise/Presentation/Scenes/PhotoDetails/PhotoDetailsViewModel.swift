//
//  PhotoDetailsViewModel.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 6.10.25.
//

import Foundation

protocol PhotoDetailsViewModel: AnyObject {
    var photo: Photo? { get set }
    var isSaved: Bool { get }
    var onDownloadPhoto: ((Data) -> Void)? { get set }
    var onPhotoChanged: ((Photo) -> Void)? { get set }
    var onPhotoSaved: (() -> Void)? { get set }
    var onPhotoDeleted: (() -> Void)? { get set }
    var onCheckedSaved: (() -> Void)? { get set }
    var onBackButtonPressed: (() -> Void)? { get set }
    
    func downloadPhoto()
    func checkIsPhotoSaved()
    func savePhoto()
    func deletePhoto()
}

class PhotoDetailsViewModelImpl: PhotoDetailsViewModel {
    private let downloadPhotoUseCase: DownloadPhotoUseCase
    private let savePhotoUseCase: SavePhotoUseCase
    private let deletePhotoUseCase: DeletePhotoUseCase
    private let isPhotoSavedUseCase: IsPhotoSavedUseCase
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                self.onPhotoChanged?(photo)
            }
        }
    }
    
    var isSaved: Bool = false
    
    var onDownloadPhoto: ((Data) -> Void)?
    var onPhotoChanged: ((Photo) -> Void)?
    var onPhotoSaved: (() -> Void)?
    var onPhotoDeleted: (() -> Void)?
    var onCheckedSaved: (() -> Void)?
    var onBackButtonPressed: (() -> Void)?
    
    init(
        downloadPhotoUseCase: DownloadPhotoUseCase,
        savePhotoUseCase: SavePhotoUseCase,
        deletePhotoUseCase: DeletePhotoUseCase,
        isPhotoSavedUseCase: IsPhotoSavedUseCase
    ) {
        self.downloadPhotoUseCase = downloadPhotoUseCase
        self.savePhotoUseCase = savePhotoUseCase
        self.deletePhotoUseCase = deletePhotoUseCase
        self.isPhotoSavedUseCase = isPhotoSavedUseCase
    }
    
    func downloadPhoto() {
        guard let photo = self.photo else { return }
        downloadPhotoUseCase.execute(url: photo.fullUrl ?? "") { [weak self] result in
            switch result {
            case .success(let data):
                self?.onDownloadPhoto?(data)
            case .failure:
                return
            }
        }
    }
    
    func checkIsPhotoSaved() {
        guard let photo = self.photo else { return }
        isPhotoSavedUseCase.execute(id: photo.id) { [weak self] result in
            switch result {
            case .success(let isSaved):
                self?.isSaved = isSaved
                self?.onCheckedSaved?()
            case .failure:
                return
            }
            
        }
    }
    
    func savePhoto() {
        guard let photo = self.photo, self.isSaved == false else { return }
        self.savePhotoUseCase.execute(photo: photo) { [weak self] result in
            switch result {
            case .success:
                self?.isSaved = true
                self?.onPhotoSaved?()
            case .failure:
                return
            }
        }
    }
    
    func deletePhoto() {
        guard let photo = self.photo, self.isSaved == true else { return }
        self.deletePhotoUseCase.execute(id: photo.id) { [weak self] result in
            switch result {
            case .success:
                self?.isSaved = false
                self?.onPhotoDeleted?()
            case .failure:
                return
            }
        }
    }
}
