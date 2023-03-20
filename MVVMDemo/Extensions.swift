//
//  Extensions.swift
//  MVVMDemo
//
//  Created by саргашкаева on 15.03.2023.
//

import UIKit


extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    func isValidPassword() -> Bool {
        return self.count >= 4
    }
}


extension LoginViewController {
    func userDoesNotExistAlert() {
        let alerController = UIAlertController(title: "Could not find the user", message: "Please make sure entered email and password are correct or register first", preferredStyle: .actionSheet)
        alerController.modalPresentationStyle = .popover
        alerController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        navigationController?.present(alerController, animated: true)
    }
}

