//
//  PhotosWaterfallCollectionViewCellViewModel.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 5.10.25.
//

import Foundation

protocol PhotosWaterfallCollectionViewCellViewModel: AnyObject {
    var photo: Photo? { get set }
    var photoIdentifier: String { get }
    var onPhotoChanged: ((Photo) -> Void)? { get set }
    var onDowloadPhoto: ((Data) -> Void)? { get set }
    var onPhotoPressed: ((Photo) -> Void)? { get set }
    
    func downloadPhoto()
}

class PhotosWaterfallCollectionViewCellViewModelImpl: PhotosWaterfallCollectionViewCellViewModel {
    private let downloadPhotoUseCase: DownloadPhotoUseCase
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                self.onPhotoChanged?(photo)
            }
        }
    }
    private(set) var photoIdentifier: String = ""
    
    var onPhotoChanged: ((Photo) -> Void)?
    var onDowloadPhoto: ((Data) -> Void)?
    var onPhotoPressed: ((Photo) -> Void)?
    
    init(downloadPhotoUseCase: DownloadPhotoUseCase) {
        self.downloadPhotoUseCase = downloadPhotoUseCase
    }
    
    func downloadPhoto() {
        guard let photo = self.photo else { return }
        self.photoIdentifier = photo.id
        let requestedPhotoId = self.photoIdentifier
        downloadPhotoUseCase.execute(url: photo.thumbnailUrl ?? "") { [weak self] result in
            guard requestedPhotoId == self?.photoIdentifier else { return }
            switch result {
            case .success(let data):
                self?.onDowloadPhoto?(data)
            case .failure:
                return
            }
        }
    }
}
