//
//  SavedPhotoRepository.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

protocol SavedPhotoRepository {
    func savePhoto(_ photo: Photo, completion: @escaping (Result<Void, Error>) -> Void)
    func deletePhoto(with id: String, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchSavedPhotos(completion: @escaping (Result<[Photo], Error>) -> Void)
    func isPhotoSaved(_ id: String, completion: @escaping (Result<Bool, Error>) -> Void)
}
