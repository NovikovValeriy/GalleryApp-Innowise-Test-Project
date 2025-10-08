//
//  SavedPhotoRepositoryImpl.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//

import CoreData

final class SavedPhotoRepositoryImpl: SavedPhotoRepository {
    private let stack: CoreDataStack

    init(stack: CoreDataStack) {
        self.stack = stack
    }

    func savePhoto(_ photo: Photo, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = stack.backgroundContext()
        context.perform {
            let entity = PhotoEntity(context: context)
            entity.id = photo.id
            entity.width = Int64(photo.width)
            entity.height = Int64(photo.height)
            entity.averageColor = photo.averageColor
            entity.descriptionText = photo.descriptionText
            entity.altDescription = photo.altDescription
            entity.thumbnailUrl = photo.thumbnailUrl
            entity.fullUrl = photo.fullUrl
            entity.authorName = photo.authorName
            entity.authorUsername = photo.authorUsername

            do {
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(SavedPhotoRepositoryError.database(.saveFailed(error))))
            }
        }
    }

    // MARK: - Delete
    func deletePhoto(with id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = stack.backgroundContext()
        context.perform {
            let request = PhotoEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)

            do {
                guard let entity = try context.fetch(request).first else {
                    completion(.failure(SavedPhotoRepositoryError.database(.objectNotFound)))
                    return
                }
                context.delete(entity)
                try context.save()
                completion(.success(()))
            } catch {
                completion(.failure(SavedPhotoRepositoryError.database(.deleteFailed(error))))
            }
        }
    }

    // MARK: - Fetch All
    func fetchSavedPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        let context = stack.backgroundContext()
        context.perform {
            let request = PhotoEntity.fetchRequest()
            do {
                let entities = try context.fetch(request)
                let photos = entities.map(PhotoEntityMapper.mapToDomain)
                completion(.success(photos))
            } catch {
                completion(.failure(SavedPhotoRepositoryError.database(.fetchFailed(error))))
            }
        }
    }

    // MARK: - Check if saved
    func isPhotoSaved(_ id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let context = stack.backgroundContext()
        context.perform {
            let request = PhotoEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)
            do {
                let count = try context.count(for: request)
                completion(.success(count > 0))
            } catch {
                completion(.failure(SavedPhotoRepositoryError.database(.fetchFailed(error))))
            }
        }
    }
}
