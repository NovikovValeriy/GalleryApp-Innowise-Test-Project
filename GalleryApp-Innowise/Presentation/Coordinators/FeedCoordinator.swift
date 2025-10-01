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
        guard let feedPhotosVC: FeedPhotosViewController = try? DependenciesContainer.shared.inject() else {
            return
        }
        navigationController.pushViewController(feedPhotosVC, animated: true)
    }
}
