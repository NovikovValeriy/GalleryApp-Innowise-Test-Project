//
//  DetailsCoordinator.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 6.10.25.
//

import UIKit

protocol DetailsCoordinatorProtocol: Coordinator {
    func showDetailsViewController()
}

class DetailsCoordinator: NSObject, DetailsCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []
    
    var photos: [Photo] = []
    var currentIndex: Int = 0

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showDetailsViewController()
    }
    
    func showDetailsViewController() {
        guard let vm: PhotoDetailsViewModel = try? DependenciesContainer.shared.inject() else {
            return
        }
        vm.photo = self.photos[self.currentIndex]
        
        vm.onBackButtonPressed = { [weak self] in
            self?.finish()
        }
        
        let detailsViewController = PhotoDetailsViewController(viewModel: vm)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}

extension DetailsCoordinator: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vm: PhotoDetailsViewModel = try? DependenciesContainer.shared.inject() else { return nil }
        
        if self.currentIndex == 0 { return nil }
        
        self.currentIndex -= 1
        vm.photo = self.photos[self.currentIndex]
        let vc = PhotoDetailsViewController(viewModel: vm)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vm: PhotoDetailsViewModel = try? DependenciesContainer.shared.inject() else { return nil }
        
        if self.currentIndex == self.photos.count - 1 { return nil }
        
        self.currentIndex += 1
        vm.photo = self.photos[self.currentIndex]
        let vc = PhotoDetailsViewController(viewModel: vm)
        return vc
    }
}
