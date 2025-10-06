//
//  PhotoDetailsPageViewController.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 6.10.25.
//

import UIKit

class PhotoDetailsPageViewController: UIPageViewController {
//    private let viewModel: PhotoDetailsPageViewModel
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        guard let vm: PhotoDetailsViewModel = try? DependenciesContainer.shared.inject() else { return }
//        vm.photo = self.viewModel.photos[self.viewModel.currentIndex]
//        let initialVC = PhotoDetailsViewController(viewModel: vm)
//        setViewControllers([initialVC], direction: .forward, animated: false)
    }
    
//    init(viewModel: PhotoDetailsPageViewModel) {
//        self.viewModel = viewModel
//        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
//    }
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
