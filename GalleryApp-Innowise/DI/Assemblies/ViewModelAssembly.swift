//
//  ViewModelAssembly.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 8.10.25.
//


import Swinject

final class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(FeedPhotosViewModel.self) { r in
            let getFeedPhotosUseCase = r.resolve(GetFeedPhotosUseCase.self)!
            let getSavedPhotosUseCase = r.resolve(GetSavedPhotosUseCase.self)!
            let errorMapper = r.resolve(ErrorMapper.self)!
            return FeedPhotosViewModelImpl(
                getFeedPhotosUseCase: getFeedPhotosUseCase,
                getSavedPhotosUseCase: getSavedPhotosUseCase,
                errorMapper: errorMapper
            )
        }.inObjectScope(.transient)
        
        container.register(PhotosWaterfallCollectionViewCellViewModel.self) { r in
            let downloadPhotoUseCase = r.resolve(DownloadPhotoUseCase.self)!
            let errorMapper = r.resolve(ErrorMapper.self)!
            return PhotosWaterfallCollectionViewCellViewModelImpl(
                downloadPhotoUseCase: downloadPhotoUseCase,
                errorMapper: errorMapper
            )
        }.inObjectScope(.transient)
        
        container.register(PhotoDetailsViewModel.self) { r in
            let downloadPhotoUseCase = r.resolve(DownloadPhotoUseCase.self)!
            let savePhotoUseCase = r.resolve(SavePhotoUseCase.self)!
            let deletePhotoUseCase = r.resolve(DeletePhotoUseCase.self)!
            let isPhotoSavedUseCase = r.resolve(IsPhotoSavedUseCase.self)!
            let errorMapper = r.resolve(ErrorMapper.self)!
            return PhotoDetailsViewModelImpl(
                downloadPhotoUseCase: downloadPhotoUseCase,
                savePhotoUseCase: savePhotoUseCase,
                deletePhotoUseCase: deletePhotoUseCase,
                isPhotoSavedUseCase: isPhotoSavedUseCase,
                errorMapper: errorMapper
            )
        }.inObjectScope(.transient)
        
        container.register(SavedPhotosViewModel.self) { r in
            let getSavedPhotosUseCase = r.resolve(GetSavedPhotosUseCase.self)!
            let errorMapper = r.resolve(ErrorMapper.self)!
            return SavedPhotosViewModelImpl(
                getSavedPhotosUseCase: getSavedPhotosUseCase,
                errorMapper: errorMapper
            )
        }.inObjectScope(.transient)
    }
}
