//
//  ContactsViewController.swift
//  MVVMDemo
//
//  Created by саргашкаева on 18.03.2023.
//


import UIKit
import SnapKit

class ContactsViewController: UIViewController {
    
    
    private let viewModel: ContactsViewModel
    
    
    private lazy var contactsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(viewModel: ContactsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true
        viewModel.fetchContacts { [weak self] in
            DispatchQueue.main.async {
                self?.contactsTableView.reloadData()
            }
        }
        setConstraints()
    }

    private func setConstraints() {
        view.backgroundColor = .white
        view.addSubview(contactsTableView)
        contactsTableView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
    }
}


extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        guard let contact = viewModel.contacts?[indexPath.row] else { return ContactTableViewCell() }
        cell.configure(with: contact)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let contact = viewModel.contacts?[indexPath.row] else { return }
        viewModel.showContacts(userId: contact.id)
    }
    
}
