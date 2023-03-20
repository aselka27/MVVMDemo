//
//  ViewController.swift
//  MVVMDemo
//
//  Created by саргашкаева on 14.03.2023.
//

import UIKit
import SnapKit
import Combine




class LoginViewController: UIViewController {
    
    
    private let loginVM: LoginViewModel
    private var cancellables = Set <AnyCancellable>()
    weak var coordinator: AuthCoordinator?
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 7))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: 7))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 16
        return button
    }()
    
    init(loginVM: LoginViewModel) {
        self.loginVM = loginVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViews()
        setConstraints()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.alpha = emailTextField.text?.isEmpty ?? false || passwordTextField.text?.isEmpty ?? false ? 0.5 : 1.0
        loginVM.delegate = self
        
    }

    private func setViews() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        emailTextField.text = loginVM.email
        passwordTextField.text = loginVM.password
    }
    
    private func setConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(80)
            make.right.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(12)
            make.right.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
            make.right.left.equalToSuperview().inset(50)
            make.height.equalTo(35)
        }
    }
    
    @objc private func loginButtonTapped() {
              loginVM.email = emailTextField.text ?? ""
              loginVM.password = passwordTextField.text ?? ""
              loginVM.loginUser()
    }
 
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return false
        }
        loginButton.isEnabled = !email.isEmpty && !password.isEmpty
        loginButton.alpha = email.isEmpty || password.isEmpty ? 0.5 : 1.0
        return true
    }
}


extension LoginViewController: LoginViewModelDelegate {
    func loginSuccess(user: User) {
       
    }
    
    func loginError(error: LoginErrors) {
        switch error {
        case .invalidEmail:
            print("Email is invalid")
        case .invalidPassword:
            print("Password is invalid")
        case .userDoesNotExist:
            userDoesNotExistAlert()
        }
    }
}
