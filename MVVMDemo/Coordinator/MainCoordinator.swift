//
//  MainCoordinator.swift
//  MVVMDemo
//
//  Created by саргашкаева on 18.03.2023.
//

import UIKit


protocol MainCoordinatorProtocol: AnyObject {
    func didFinishMainCoordinator(coordinator: Coordinator)
}


class MainCoordinator: Coordinator {
   
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    public weak var delegate: MainCoordinatorProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = ContactsViewModel()
        vm.mainCoordinator = self
        let vc = ContactsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetailViewWith(userId: Int) {
        let vm = CommentsViewModel()
        vm.userId = userId
        let vc = CommentsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
