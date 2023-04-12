//
//  UserInfoTableViewCell.swift
//  MVVMDemo
//
//  Created by саргашкаева on 22.03.2023.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {
    
    static let identifier = "UserInfoTableViewCell"

    let dateTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDateTextField))
    var openDatePicker: (() -> Void)?
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private lazy var userInputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.leftView = UIView(frame: .init(x: 0, y: 0, width: 5, height: 5))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = false
        textField.delegate = self
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(infoLabel)
        contentView.addSubview(userInputTextField)
        contentView.isUserInteractionEnabled = false
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.left.equalToSuperview().offset(16)
        }
        userInputTextField.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
    
    
    public func configure(with model: UserInput) {
        infoLabel.text = model.input
        userInputTextField.isUserInteractionEnabled = true
       // gestureRecognizers?.removeAll()
        userInputTextField.placeholder = model.placeholder
        userInputTextField.isSecureTextEntry = model.type == InputType.Password ? true : false
        userInputTextField.keyboardType = model.type == InputType.Password ? .numberPad : .default
        if model.type == InputType.DatePicker {
            userInputTextField.isUserInteractionEnabled = false
            userInputTextField.addGestureRecognizer(dateTapGesture)
        } else {
           userInputTextField.isUserInteractionEnabled = false
        }
        
    }
    
    @objc private func didTapDateTextField() {
        openDatePicker?()
    }
    
    func setTextFieldText(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        guard let date = dateFormatter.date(from: dateString) else { return }
        dateFormatter.dateFormat = "dd / MM / yyyy"
        let formattedDate = dateFormatter.string(from: date)
        userInputTextField.text = formattedDate
    }
}


extension UserInfoTableViewCell: UITextFieldDelegate {
    
}
