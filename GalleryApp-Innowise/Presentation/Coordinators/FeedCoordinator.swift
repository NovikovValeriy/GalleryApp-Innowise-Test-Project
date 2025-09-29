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
    
    var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showFeedViewController()
    }
    
    func showFeedViewController() {
        let feedPhotosVC = FeedPhotosViewController()
        navigationController.pushViewController(feedPhotosVC, animated: true)
    }
}
