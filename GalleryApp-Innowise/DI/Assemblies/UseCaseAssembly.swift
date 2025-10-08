//
//  UseCaseAssembly.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 8.10.25.
//

import Swinject

final class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetFeedPhotosUseCase.self) { resolver in
            let photoRepository = resolver.resolve(PhotoRepository.self)!
            return GetFeedPhotosUseCaseImpl(repository: photoRepository)
        }.inObjectScope(.transient)
        
        container.register(DownloadPhotoUseCase.self) { resolver in
            let photoRepository = resolver.resolve(PhotoRepository.self)!
            return DownloadPhotoUseCaseImpl(repository: photoRepository)
        }.inObjectScope(.transient)
        
        container.register(GetSavedPhotosUseCase.self) { resolver in
            let savedPhotoRepository = resolver.resolve(SavedPhotoRepository.self)!
            return GetSavedPhotosUseCaseImpl(repository: savedPhotoRepository)
        }.inObjectScope(.transient)
        
        container.register(SavePhotoUseCase.self) { resolver in
            let savedPhotoRepository = resolver.resolve(SavedPhotoRepository.self)!
            return SavePhotoUseCaseImpl(repository: savedPhotoRepository)
        }.inObjectScope(.transient)
        
        container.register(DeletePhotoUseCase.self) { resolver in
            let savedPhotoRepository = resolver.resolve(SavedPhotoRepository.self)!
            return DeletePhotoUseCaseImpl(repository: savedPhotoRepository)
        }.inObjectScope(.transient)
        
        container.register(IsPhotoSavedUseCase.self) { resolver in
            let savedPhotoRepository = resolver.resolve(SavedPhotoRepository.self)!
            return IsPhotoSavedUseCaseImpl(repository: savedPhotoRepository)
        }.inObjectScope(.transient)
    }
}
