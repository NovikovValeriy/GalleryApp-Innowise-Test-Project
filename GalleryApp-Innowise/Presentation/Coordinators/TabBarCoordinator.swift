//
//  TabBarCoordinator.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 29.09.25.
//

import UIKit

enum TabBarItem: Int {
    case feed = 0
    case saved = 1

    var title: String {
        switch self {
        case .feed:
            return "Feed"
        case .saved:
            return "Favorite"
        }
    }

    var iconName: String {
        switch self {
        case .feed:
            return "house"
        case .saved:
            return "heart"
        }
    }

    var selectedIconName: String {
        switch self {
        case .feed:
            return "house.fill"
        case .saved:
            return "heart.fill"
        }
    }
}

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
}

final class TabBarCoordinator: TabCoordinatorProtocol {
    var tabBarController: UITabBarController

    var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators: [Coordinator] = []

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }

    func start() {
        let pages: [TabBarItem] = [.feed, .saved]
            .sorted(by: { $0.rawValue < $1.rawValue })

        let controllers: [UINavigationController] = pages.map({ getTabController($0) })

        prepareTabBarController(withTabControllers: controllers)
    }

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarItem.feed.rawValue
        tabBarController.tabBar.isTranslucent = false

        navigationController.viewControllers = [tabBarController]
    }

    private func getTabController(_ page: TabBarItem) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)

        let defaultImageConfiguration = UIImage.SymbolConfiguration(weight: .regular)
        let selectedImageConfiguration = UIImage.SymbolConfiguration(weight: .semibold)
        if let tabBarItem = navController.tabBarItem {
            tabBarItem.title = page.title
            tabBarItem.image = UIImage(systemName: page.iconName, withConfiguration: defaultImageConfiguration)
            tabBarItem.selectedImage = UIImage(systemName: page.selectedIconName,
                                               withConfiguration: selectedImageConfiguration)
        }

        switch page {
        case .feed:
            let feedCoordinator = FeedCoordinator(navController)
            childCoordinators.append(feedCoordinator)
            feedCoordinator.start()
        case .saved:
            let savedCoordinator = SavedCoordinator(navController)
            childCoordinators.append(savedCoordinator)
            savedCoordinator.start()
        }

        return navController
    }
}
