//
//  PhotoRepositoryError.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

enum PhotoRepositoryError: Error {
    case network(NetworkError)
    case cache(CacheError)
    case emptyResult
}
