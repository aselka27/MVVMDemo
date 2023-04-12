//
//  RegisterViewController.swift
//  MVVMDemo
//
//  Created by саргашкаева on 22.03.2023.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    
    var inputModel: [UserInput] = []
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var infoTableView: DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: UserInfoTableViewCell.identifier)
        return tableView
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = false 
        return button
    }()
    
    deinit {
        removeKeyboardNotification()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(infoTableView)
        containerView.addSubview(signUpButton)
        
         inputModel = [UserInput(input: "Enter your full name", placeholder: "name", type: .OtherField),
                          UserInput(input: "Enter your email", placeholder: "email", type: .OtherField),
                          UserInput(input: "Enter your date of birth", placeholder: "date of birth", type: .DatePicker),
                          UserInput(input: "Create password", placeholder: "password", type: .Password)
        
        ]
        
        setConstraints()
        registerKeyboardNotification()
    }

    private func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.right.equalToSuperview()
        }
        signUpButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(45)
            make.top.equalTo(infoTableView.snp.bottom).offset(20)
        }
    }
    
    private func configureTableView() {
       
    }
}


extension RegisterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        inputModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoTableViewCell.identifier, for: indexPath) as! UserInfoTableViewCell
        cell.configure(with: inputModel[indexPath.row])
        cell.openDatePicker = { [weak self] in
            self?.view.endEditing(true)
            let vc = PickDateController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.providesPresentationContextTransitionStyle = true
            vc.definesPresentationContext = true
            vc.modalTransitionStyle = .crossDissolve
            self?.navigationController?.present(vc, animated: true)
        
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}


extension RegisterViewController {
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2)
    }
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
}
