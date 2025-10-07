//
//  DependenciesContainer.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 1.10.25.
//

import Swinject
import Foundation

class DependenciesContainer {
    static let shared = DependenciesContainer()
    private let container = Container()
    
    func inject<T>() throws -> T {
        if let container = container.resolve(T.self) {
            return container
        } else {
            throw NSError()
        }
    }
    
    private init() {
        self.registerDependencies()
    }
    
    private func registerDependencies() {
        self.registerRepositoryDependencies()
        self.registerUseCaseDependencies()
        self.registerViewModelDependencies()
    }
    
    private func registerRepositoryDependencies() {
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
    
    private func registerUseCaseDependencies() {
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
    
    private func registerViewModelDependencies() {
        container.register(FeedPhotosViewModel.self) { r in
            let getFeedPhotosUseCase = r.resolve(GetFeedPhotosUseCase.self)!
            let getSavedPhotosUseCase = r.resolve(GetSavedPhotosUseCase.self)!
            return FeedPhotosViewModelImpl(getFeedPhotosUseCase: getFeedPhotosUseCase, getSavedPhotosUseCase: getSavedPhotosUseCase)
        }.inObjectScope(.transient)
        
        container.register(PhotosWaterfallCollectionViewCellViewModel.self) { r in
            let downloadPhotoUseCase = r.resolve(DownloadPhotoUseCase.self)!
            return PhotosWaterfallCollectionViewCellViewModelImpl(downloadPhotoUseCase: downloadPhotoUseCase)
        }.inObjectScope(.transient)
        
        container.register(PhotoDetailsViewModel.self) { r in
            let downloadPhotoUseCase = r.resolve(DownloadPhotoUseCase.self)!
            let savePhotoUseCase = r.resolve(SavePhotoUseCase.self)!
            let deletePhotoUseCase = r.resolve(DeletePhotoUseCase.self)!
            let isPhotoSavedUseCase = r.resolve(IsPhotoSavedUseCase.self)!
            return PhotoDetailsViewModelImpl(
                downloadPhotoUseCase: downloadPhotoUseCase,
                savePhotoUseCase: savePhotoUseCase,
                deletePhotoUseCase: deletePhotoUseCase,
                isPhotoSavedUseCase: isPhotoSavedUseCase
            )
        }.inObjectScope(.transient)
        
        container.register(SavedPhotosViewModel.self) { r in
            let getSavedPhotosUseCase = r.resolve(GetSavedPhotosUseCase.self)!
            return SavedPhotosViewModelImpl(getSavedPhotosUseCase: getSavedPhotosUseCase)
        }
    }
}
