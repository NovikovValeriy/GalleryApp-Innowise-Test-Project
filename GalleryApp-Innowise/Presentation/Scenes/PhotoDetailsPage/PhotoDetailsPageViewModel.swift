//
//  PhotoDetailsPageViewModel.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 6.10.25.
//

import Foundation

protocol PhotoDetailsPageViewModel: AnyObject {
    var photos: [Photo] { get set }
    var currentIndex: Int { get set }
}

class PhotoDetailsPageViewModelImpl: PhotoDetailsPageViewModel {
    var photos: [Photo] = []
    var currentIndex: Int = 0
}
