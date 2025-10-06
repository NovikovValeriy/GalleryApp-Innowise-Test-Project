//
//  PhotoDetailsViewModel.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 6.10.25.
//

import Foundation

protocol PhotoDetailsViewModel: AnyObject {
    var photo: Photo? { get set }
    var onDownloadPhoto: ((Data) -> Void)? { get set }
    var onPhotoChanged: ((Photo) -> Void)? { get set }
    var onBackButtonPressed: (() -> Void)? { get set }
    
    func downloadPhoto()
}

import Foundation

class PhotoDetailsViewModelImpl: PhotoDetailsViewModel {
    private let downloadPhotoUseCase: DownloadPhotoUseCase
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                self.onPhotoChanged?(photo)
            }
        }
    }
    
    var onDownloadPhoto: ((Data) -> Void)?
    var onPhotoChanged: ((Photo) -> Void)?
    var onBackButtonPressed: (() -> Void)?
    
    init(downloadPhotoUseCase: DownloadPhotoUseCase) {
        self.downloadPhotoUseCase = downloadPhotoUseCase
    }
    
    func downloadPhoto() {
        downloadPhotoUseCase.execute(url: photo?.fullUrl ?? "") { [weak self] result in
            switch result {
            case .success(let data):
                self?.onDownloadPhoto?(data)
            case .failure:
                return
            }
        }
    }
}
