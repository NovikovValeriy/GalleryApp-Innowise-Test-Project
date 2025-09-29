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

class SavedCoordinator: SavedCoordinatorProtocol {

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
        let savedPhotosVC = SavedPhotosViewController()
        navigationController.pushViewController(savedPhotosVC, animated: true)
    }
}
