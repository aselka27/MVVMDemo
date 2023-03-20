//
//  AuthCoordinator.swift
//  MVVMDemo
//
//  Created by саргашкаева on 18.03.2023.
//

import UIKit

protocol AuthCoordinatorProtocol: AnyObject {
    func didFinishAuthCoordinator(coordinator: Coordinator)
}


class AuthCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    public weak var delegate: AuthCoordinatorProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = LoginViewModel()
        vm.authCoordinatorDelegate = self
        let vc = LoginViewController(loginVM: vm)
        vc.coordinator = self 
        navigationController.pushViewController(vc, animated: false)
    }
    
    func errorAlert(title: String, message: String) {
        let alerController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alerController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        navigationController.present(alerController, animated: true)
    }
}


extension AuthCoordinator: LoginViewModelCoordinatorDelegate {
    func successSigningIn(user: User) {
        self.delegate?.didFinishAuthCoordinator(coordinator: self)
    }
    
    func failedToSignUp(error: LoginErrors) {
        switch error {
        case .invalidEmail:
            print("invalid email")
        case .invalidPassword:
            print("invalid password")
        case .userDoesNotExist:
            errorAlert(title: "Could not find the user", message: "Please make sure entered email and password are correct or register first")
            print("user does not exist")
        }
    }
    
    
}
