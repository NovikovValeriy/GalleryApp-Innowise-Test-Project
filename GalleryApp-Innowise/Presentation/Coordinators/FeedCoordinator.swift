//
//  FeedCoordinator.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import UIKit

protocol FeedCoordinatorProtocol: Coordinator {
    func showFeedViewController()
    func showDetailsFlow(photos: [Photo], index: Int)
}

class FeedCoordinator: FeedCoordinatorProtocol {

    weak var finishDelegate: CoordinatorFinishDelegate?

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
        viewModel.onPhotoPressed = { [weak self, weak viewModel] index in
            guard let self = self, let viewModel = viewModel else { return }
            self.showDetailsFlow(photos: viewModel.photos, index: index)
        }
        let feedPhotosVC = FeedPhotosViewController(viewModel: viewModel)
        navigationController.pushViewController(feedPhotosVC, animated: true)
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

extension FeedCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: any Coordinator) {
        self.navigationController.popViewController(animated: true)
    }
}
