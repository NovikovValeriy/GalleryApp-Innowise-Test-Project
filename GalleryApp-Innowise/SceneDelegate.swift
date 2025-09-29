//
//  SceneDelegate.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 28.09.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        self.window = window
        self.window?.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator(navigationController)
        appCoordinator?.start()
    }
    
    
}

