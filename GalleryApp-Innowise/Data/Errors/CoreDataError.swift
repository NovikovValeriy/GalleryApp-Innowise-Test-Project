//
//  CoreDataError.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

enum CoreDataError: Error {
    case saveFailed(Error)
    case fetchFailed(Error)
    case deleteFailed(Error)
    case objectNotFound
}
