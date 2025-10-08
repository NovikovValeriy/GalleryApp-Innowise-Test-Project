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

final class DetailsCoordinator: NSObject, DetailsCoordinatorProtocol {

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
        guard let viewModel: PhotoDetailsViewModel = try? DependenciesContainer.shared.inject() else {
            return
        }
        viewModel.photo = self.photos[self.currentIndex]
        
        viewModel.onBackButtonPressed = { [weak self] in
            self?.finish()
        }
        
        let detailsPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        detailsPageViewController.dataSource = self
        detailsPageViewController.delegate = self
        let detailsViewController = PhotoDetailsViewController(viewModel: viewModel)
        detailsPageViewController.setViewControllers([detailsViewController], direction: .forward, animated: false)
        navigationController.pushViewController(detailsPageViewController, animated: true)
    }
}

extension DetailsCoordinator: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if self.currentIndex == 0 { return nil }
        let index = self.currentIndex - 1
        guard let viewModel = self.setupPhotoDetailsViewModel(index: index) else { return nil }
        let viewController = PhotoDetailsViewController(viewModel: viewModel)
        return viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if self.currentIndex == self.photos.count - 1 { return nil }
        let index = self.currentIndex + 1
        guard let viewModel = self.setupPhotoDetailsViewModel(index: index) else { return nil }
        let viewController = PhotoDetailsViewController(viewModel: viewModel)
        return viewController
    }
    
    private func setupPhotoDetailsViewModel(index: Int) -> PhotoDetailsViewModel? {
        guard let viewModel: PhotoDetailsViewModel = try? DependenciesContainer.shared.inject() else { return nil }
        viewModel.onBackButtonPressed = { [weak self] in
            self?.finish()
        }
        viewModel.photo = self.photos[index]
        return viewModel
    }
}

extension DetailsCoordinator: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool) {
        guard
            let detailVCs = pageViewController.viewControllers as? [PhotoDetailsViewController],
            let photo = detailVCs[0].photo,
            let currIndex = photos.firstIndex(of: photo)
        else { return }
        
        currentIndex = currIndex
    }
}
