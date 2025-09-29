//
//  PhotoRepository.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import Foundation

protocol PhotoRepository {
    func getFeedPhotos(page: Int, perPage: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
    func downloadPhoto(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
