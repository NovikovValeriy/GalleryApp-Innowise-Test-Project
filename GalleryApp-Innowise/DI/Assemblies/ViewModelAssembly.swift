//
//  ViewModelAssembly.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 8.10.25.
//

import Swinject

final class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FeedPhotosViewModel.self) { resolver in
            let getFeedPhotosUseCase = resolver.resolve(GetFeedPhotosUseCase.self)!
            let getSavedPhotosUseCase = resolver.resolve(GetSavedPhotosUseCase.self)!
            let errorMapper = resolver.resolve(ErrorMapper.self)!
            return FeedPhotosViewModelImpl(
                getFeedPhotosUseCase: getFeedPhotosUseCase,
                getSavedPhotosUseCase: getSavedPhotosUseCase,
                errorMapper: errorMapper
            )
        }.inObjectScope(.transient)
        
        container.register(WaterfallCollectionViewCellViewModel.self) { resolver in
            let downloadPhotoUseCase = resolver.resolve(DownloadPhotoUseCase.self)!
            let errorMapper = resolver.resolve(ErrorMapper.self)!
            return WaterfallCollectionViewCellViewModelImpl(
                downloadPhotoUseCase: downloadPhotoUseCase,
                errorMapper: errorMapper
            )
        }.inObjectScope(.transient)
        
        container.register(PhotoDetailsViewModel.self) { resolver in
            let downloadPhotoUseCase = resolver.resolve(DownloadPhotoUseCase.self)!
            let savePhotoUseCase = resolver.resolve(SavePhotoUseCase.self)!
            let deletePhotoUseCase = resolver.resolve(DeletePhotoUseCase.self)!
            let isPhotoSavedUseCase = resolver.resolve(IsPhotoSavedUseCase.self)!
            let errorMapper = resolver.resolve(ErrorMapper.self)!
            return PhotoDetailsViewModelImpl(
                downloadPhotoUseCase: downloadPhotoUseCase,
                savePhotoUseCase: savePhotoUseCase,
                deletePhotoUseCase: deletePhotoUseCase,
                isPhotoSavedUseCase: isPhotoSavedUseCase,
                errorMapper: errorMapper
            )
        }.inObjectScope(.transient)
        
        container.register(SavedPhotosViewModel.self) { resolver in
            let getSavedPhotosUseCase = resolver.resolve(GetSavedPhotosUseCase.self)!
            let errorMapper = resolver.resolve(ErrorMapper.self)!
            return SavedPhotosViewModelImpl(
                getSavedPhotosUseCase: getSavedPhotosUseCase,
                errorMapper: errorMapper
            )
        }.inObjectScope(.transient)
    }
}
