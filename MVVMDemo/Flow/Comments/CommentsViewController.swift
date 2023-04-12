//
//  CommentsViewController.swift
//  MVVMDemo
//
//  Created by саргашкаева on 20.03.2023.
//

import UIKit
import SnapKit

class CommentsViewController: UIViewController {
    
    
    let viewModel: CommentsViewModel
  
    private lazy var commentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    
    init(viewModel: CommentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        
        commentsTableView.estimatedRowHeight = 60
        commentsTableView.rowHeight = UITableView.automaticDimension
        
        navigationController?.navigationBar.prefersLargeTitles = true
        viewModel.fetchComments { [weak self] in
            DispatchQueue.main.async {
                self?.commentsTableView.reloadData()
                self?.title = "\(self?.viewModel.comments?.first?.userId ?? 0)"
            }
        }
    }
    
    private func setConstraints() {
        view.backgroundColor = .white
        view.addSubview(commentsTableView)

        commentsTableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.bottom.equalToSuperview()
        }
    }

}


extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        guard let comment = viewModel.comments?[indexPath.row] else { return ContactTableViewCell() }
        cell.configureComments(with: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

