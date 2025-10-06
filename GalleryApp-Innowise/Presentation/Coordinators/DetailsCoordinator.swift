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
        
        let detailsPageViewController = PhotoDetailsPageViewController()
        detailsPageViewController.dataSource = self
        detailsPageViewController.delegate = self
        let detailsViewController = PhotoDetailsViewController(viewModel: vm)
        detailsPageViewController.setViewControllers([detailsViewController], direction: .forward, animated: false)
        navigationController.pushViewController(detailsPageViewController, animated: true)
    }
}

extension DetailsCoordinator: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if self.currentIndex == 0 { return nil }
        let index = self.currentIndex - 1
        guard let vm = self.setupPhotoDetailsViewModel(index: index) else { return nil }
        let vc = PhotoDetailsViewController(viewModel: vm)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if self.currentIndex == self.photos.count - 1 { return nil }
        let index = self.currentIndex + 1
        guard let vm = self.setupPhotoDetailsViewModel(index: index) else { return nil }
        let vc = PhotoDetailsViewController(viewModel: vm)
        return vc
    }
    
    private func setupPhotoDetailsViewModel(index: Int) -> PhotoDetailsViewModel? {
        guard let vm: PhotoDetailsViewModel = try? DependenciesContainer.shared.inject() else { return nil }
        vm.onBackButtonPressed = { [weak self] in
            self?.finish()
        }
        vm.photo = self.photos[index]
        return vm
    }
}

extension DetailsCoordinator: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool)
    {
        guard
            let detailVCs = pageViewController.viewControllers as? [PhotoDetailsViewController],
            let photo = detailVCs[0].viewModel.photo,
            let currIndex = photos.firstIndex(of: photo)
        else { return }
        
        currentIndex = currIndex
    }
}
