//
//  LoginCombineViewModel.swift
//  MVVMDemo
//
//  Created by саргашкаева on 17.03.2023.
//

import Combine
import Foundation

enum ViewStates {
    case loading
    case success
    case failed
    case none
}


class LoginCombineViewModel {
    
    
    @Published var email = ""
    @Published var password = ""
    @Published var state: ViewStates = .none
    
    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isValidEmail() }
            .eraseToAnyPublisher()
    }
    
    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { $0.isValidPassword() }
            .eraseToAnyPublisher()
    }
    
    var isLoginEnabled: AnyPublisher <Bool, Never> {
        Publishers.CombineLatest(isValidEmailPublisher, isValidPasswordPublisher)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
    
    func isCorrectLogin() -> Bool {
      let user = User(email: email, password: password)
       return users.contains(where: { $0 == user })
    }
    
    func submitLogin() {
        state = .loading
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            if ((self?.isCorrectLogin()) != nil) {
                self?.state = .success
            } else {
                self?.state = .failed
            }
        }
        
    }
    
}


//
//func bindViewModel() {
//    NotificationCenter.default
//        .publisher(for: UITextField.textDidChangeNotification, object: emailTextField)
//        .map { ($0.object as? UITextField)?.text ?? "" }
//        .assign(to: \.email, on: LoginCombineViewModel())
//        .store(in: &cancellables)
//    NotificationCenter.default
//        .publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
//        .map { ($0.object as? UITextField)?.text ?? "" }
//        .assign(to: \.password, on: LoginCombineViewModel())
//        .store(in: &cancellables)
//
//    LoginCombineViewModel().isLoginEnabled
//        .assign(to: \.isEnabled, on: loginButton)
//        .store(in: &cancellables)
//    
////        LoginCombineViewModel().$state
////            .sink { [weak self] in
////                switch state {
////                case .loading:
////
////                }
////            }
//}
