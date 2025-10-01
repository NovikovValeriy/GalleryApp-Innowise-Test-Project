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
        self.registerGeneralDependencies()
        self.registerViewControllersDependenices()
    }
    
    private func registerGeneralDependencies() {
        container.register(PhotoRepository.self) { _ in
            let apiDataSource = UnsplashAPIDataSource()
            return PhotoRepositoryImpl(unsplashAPIDataSource: apiDataSource)
        }.inObjectScope(.container)
        
        container.register(GetFeedPhotosUseCase.self) { r in
            let photoRepository = r.resolve(PhotoRepository.self)!
            return GetFeedPhotosUseCaseImpl(repository: photoRepository)
        }.inObjectScope(.container)
        
    }
    
    private func registerViewControllersDependenices() {
        container.register(FeedPhotosViewController.self) { r in
            return FeedPhotosViewController()
        }
        
        container.register(SavedPhotosViewController.self) { r in
            return SavedPhotosViewController()
        }
    }
}
