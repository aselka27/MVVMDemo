//
//  Coordinator.swift
//  MVVMDemo
//
//  Created by саргашкаева on 18.03.2023.
//

import UIKit



protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}


extension Coordinator {
    func append(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
