//
//  LoginViewModel.swift
//  MVVMDemo
//
//  Created by саргашкаева on 15.03.2023.
//

import Foundation

var users: [User] = [
 User(email: "asjumalieva@gmail.com", password: "723567"),
 User(email: "winona.ryder@gmail.com", password: "123456")

]

enum LoginErrors: Error {
    case invalidEmail
    case invalidPassword
    case userDoesNotExist
    
    var description: String {
        switch self {
        case .invalidEmail:
            return "Please make sure that entered email is correct"
        case .invalidPassword:
            return "Password must contain at least 4 characters"
        case .userDoesNotExist:
            return "Account was not found. Please register first!"
        }
    }
}


protocol LoginViewModelDelegate: AnyObject {
    func loginSuccess(user: User)
    func loginError(error: LoginErrors)
}

protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func successSigningIn(user: User)
    func failedToSignUp(error: LoginErrors)
}

class LoginViewModel {
    
    var email: String = ""
    var password: String = ""
    weak var delegate: LoginViewModelDelegate?
    weak var authCoordinatorDelegate: LoginViewModelCoordinatorDelegate?
    
  
    
   
    func loginUser() {
        let user = User(email: email, password: password)
        
        guard users.contains(where: {$0 == user }) else {
            delegate?.loginError(error: .userDoesNotExist)
            authCoordinatorDelegate?.failedToSignUp(error: .userDoesNotExist)
            return 
        }
        //delegate?.loginSuccess(user: user)
        DispatchQueue.main.async {
            UserDefaultsService.shared.saveLoggedState(isLogged: true)
        }
        authCoordinatorDelegate?.successSigningIn(user: user)
        
        
    }
}
