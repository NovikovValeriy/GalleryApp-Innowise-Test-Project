//
//  AppCoordinator.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showMainFlow()
}

class AppCoordinator: AppCoordinatorProtocol {
    
    var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        showMainFlow()
    }
    
    func showMainFlow() {
        let tabBarCoordinator = TabBarCoordinator(self.navigationController)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
    }
}
