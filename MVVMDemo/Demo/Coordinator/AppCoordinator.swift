//
//  AppCoordinator.swift
//  MVVMDemo
//
//  Created by саргашкаева on 18.03.2023.
//

import UIKit


class AppCoordinator: Coordinator {
   
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        if true {
            runAuthFlow()
        } else {
            runMainFlow()
        }
    }
    
    func runAuthFlow() {
      let child = AuthCoordinator(navigationController: navigationController)
        append(coordinator: child)
        child.delegate = self
        child.start()
    }
    
    func runMainFlow() {
        let child = MainCoordinator(navigationController: navigationController)
        append(coordinator: child)
        child.delegate = self
        child.start()
    }
}

extension AppCoordinator: AuthCoordinatorProtocol {
    func didFinishAuthCoordinator(coordinator: Coordinator) {
        remove(coordinator: coordinator)
        navigationController.viewControllers.removeAll()
        runMainFlow()
    }
}

extension AppCoordinator: MainCoordinatorProtocol {
    func didFinishMainCoordinator(coordinator: Coordinator) {
        remove(coordinator: coordinator)
        navigationController.viewControllers.removeAll()
        runAuthFlow()
    }
}
