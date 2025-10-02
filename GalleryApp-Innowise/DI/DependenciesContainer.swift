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
        self.registerViewControllersDependenices()
    }
    
    private func registerRepositoryDependencies() {
        container.register(PhotoRepository.self) { _ in
            let apiDataSource = UnsplashAPIDataSource()
            return PhotoRepositoryImpl(unsplashAPIDataSource: apiDataSource)
        }.inObjectScope(.container)
    }
    
    private func registerUseCaseDependencies() {
        container.register(GetFeedPhotosUseCase.self) { r in
            let photoRepository = r.resolve(PhotoRepository.self)!
            return GetFeedPhotosUseCaseImpl(repository: photoRepository)
        }.inObjectScope(.container)
    }
    
    private func registerViewModelDependencies() {
        container.register(FeedPhotosViewModel.self) { r in
            let getFeedPhotosUseCase = r.resolve(GetFeedPhotosUseCase.self)!
            return FeedPhotosViewModelImpl(getFeedPhotosUseCase: getFeedPhotosUseCase)
        }.inObjectScope(.container)
    }
    
    private func registerViewControllersDependenices() {
        container.register(FeedPhotosViewController.self) { r in
            let viewModel = r.resolve(FeedPhotosViewModel.self)!
            return FeedPhotosViewController(viewModel: viewModel)
        }
        
        container.register(SavedPhotosViewController.self) { r in
            return SavedPhotosViewController()
        }
    }
}
