//
//  UseCaseAssembly.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 8.10.25.
//


import Swinject

final class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GetFeedPhotosUseCase.self) { r in
            let photoRepository = r.resolve(PhotoRepository.self)!
            return GetFeedPhotosUseCaseImpl(repository: photoRepository)
        }.inObjectScope(.transient)
        
        container.register(DownloadPhotoUseCase.self) { r in
            let photoRepository = r.resolve(PhotoRepository.self)!
            return DownloadPhotoUseCaseImpl(repository: photoRepository)
        }.inObjectScope(.transient)
        
        container.register(GetSavedPhotosUseCase.self) { r in
            let savedPhotoRepository = r.resolve(SavedPhotoRepository.self)!
            return GetSavedPhotosUseCaseImpl(repository: savedPhotoRepository)
        }.inObjectScope(.transient)
        
        container.register(SavePhotoUseCase.self) { r in
            let savedPhotoRepository = r.resolve(SavedPhotoRepository.self)!
            return SavePhotoUseCaseImpl(repository: savedPhotoRepository)
        }.inObjectScope(.transient)
        
        container.register(DeletePhotoUseCase.self) { r in
            let savedPhotoRepository = r.resolve(SavedPhotoRepository.self)!
            return DeletePhotoUseCaseImpl(repository: savedPhotoRepository)
        }.inObjectScope(.transient)
        
        container.register(IsPhotoSavedUseCase.self) { r in
            let savedPhotoRepository = r.resolve(SavedPhotoRepository.self)!
            return IsPhotoSavedUseCaseImpl(repository: savedPhotoRepository)
        }.inObjectScope(.transient)
    }
}
