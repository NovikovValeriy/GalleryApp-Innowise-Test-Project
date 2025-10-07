//
//  SavedPhotoRepositoryError.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

enum SavedPhotoRepositoryError: Error {
    case database(CoreDataError)
}
