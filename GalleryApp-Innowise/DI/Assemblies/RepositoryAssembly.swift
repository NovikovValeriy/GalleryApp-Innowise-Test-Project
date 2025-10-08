//
//  RepositoryAssembly.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 8.10.25.
//

import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PhotoRepository.self) { _ in
            let apiDataSource = UnsplashAPIDataSource()
            let photoCacheDataSource = PhotoCacheDataSource()
            return PhotoRepositoryImpl(unsplashAPIDataSource: apiDataSource, photoCacheDataCource: photoCacheDataSource)
        }.inObjectScope(.container)
        
        container.register(SavedPhotoRepository.self) { _ in
            let stack = CoreDataStack.shared
            return SavedPhotoRepositoryImpl(stack: stack)
        }.inObjectScope(.container)
    }
}
