//
//  DatePickerViewController.swift
//  MVVMDemo
//
//  Created by саргашкаева on 23.03.2023.
//

import UIKit


protocol PickDateToDelegate: AnyObject {
    func didSelectTo(date: Date)
}

protocol PickDateControllerDelegate: AnyObject {
    func didSelectDate(date: Date)
}

class PickDateController: UIViewController {
    
    weak var delegate: PickDateControllerDelegate?
    weak var pickDateToDelegate: PickDateToDelegate?
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        picker.datePickerMode = .date
        picker.sizeToFit()
        picker.layer.masksToBounds = true
        picker.backgroundColor = .white
        picker.locale = Locale(identifier: "ru")
        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        dateComponents.month = 12
        dateComponents.day = 31
        let lastDayOfCurrentYear = calendar.date(from: dateComponents)
        picker.maximumDate = lastDayOfCurrentYear
        return picker
    }()
    
    lazy var saveDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.addTarget(self, action: #selector(saveDateButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(datePicker)
        view.addSubview(saveDateButton)
        setupConstraints()
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissVC)))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = .black.withAlphaComponent(0.6)
        datePicker.layer.cornerRadius = 24
        datePicker.layer.masksToBounds = false
    }
    
    private func setupConstraints() {
        datePicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(219)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(80)
        }
        
        saveDateButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(datePicker.snp.bottom).offset(7)
        }
    }
    
    @objc func saveDateButtonTapped() {
        if delegate != nil {
            delegate?.didSelectDate(date: datePicker.date)
        }
        if pickDateToDelegate != nil {
            pickDateToDelegate?.didSelectTo(date: datePicker.date)
        }
    }
    
    @objc func dismissVC() {
//        coordinator?.dismissDatePicker()
        dismiss(animated: true)
    }
}
