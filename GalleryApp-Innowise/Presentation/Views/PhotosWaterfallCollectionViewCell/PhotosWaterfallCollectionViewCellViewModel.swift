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
    
    func downloadPhoto()
}

class PhotosWaterfallCollectionViewCellViewModelImpl: PhotosWaterfallCollectionViewCellViewModel {
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
    
    func downloadPhoto() {
        
    }
}
