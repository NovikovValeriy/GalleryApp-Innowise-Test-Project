//
//  FeedCoordinator.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import UIKit

protocol FeedCoordinatorProtocol: Coordinator {
    func showFeedViewController()
}

class FeedCoordinator: FeedCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showFeedViewController()
    }

    func showFeedViewController() {
        guard let viewModel: FeedPhotosViewModel = try? DependenciesContainer.shared.inject() else {
            return
        }
        viewModel.onPhotoPressed = { [weak self] photo in
            self?.showDetailsViewController(for: photo)
        }
        let feedPhotosVC = FeedPhotosViewController(viewModel: viewModel)
        navigationController.pushViewController(feedPhotosVC, animated: true)
    }
    
    func showDetailsViewController(for photo: Photo) {
        guard let vm: PhotoDetailsViewModel = try? DependenciesContainer.shared.inject() else {
            return
        }
        vm.photo = photo
        
        vm.onBackButtonPressed = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        let detailsViewController = PhotoDetailsViewController(viewModel: vm)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
