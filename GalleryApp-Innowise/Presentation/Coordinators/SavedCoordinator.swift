//
//  SavedCoordinator.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import UIKit

protocol SavedCoordinatorProtocol: Coordinator {
    func showSavedViewController()
}

final class SavedCoordinator: SavedCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showSavedViewController()
    }

    func showSavedViewController() {
        guard let viewModel: SavedPhotosViewModel = try? DependenciesContainer.shared.inject() else {
            return
        }
        viewModel.onPhotoPressed = { [weak self, weak viewModel] index in
            guard let self = self, let viewModel = viewModel else { return }
            self.showDetailsFlow(photos: viewModel.photos, index: index)
        }
        let savedPhotosVC = SavedPhotosViewController(viewModel: viewModel)
        navigationController.pushViewController(savedPhotosVC, animated: true)
    }
    
    func showDetailsFlow(photos: [Photo], index: Int) {
        let detailsCoordinator = DetailsCoordinator(navigationController)
        detailsCoordinator.photos = photos
        detailsCoordinator.currentIndex = index
        childCoordinators.append(detailsCoordinator)
        detailsCoordinator.finishDelegate = self
        detailsCoordinator.start()
    }
}

extension SavedCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.navigationController.popViewController(animated: true)
    }
}
