//
//  ContactTableViewCell.swift
//  MVVMDemo
//
//  Created by саргашкаева on 18.03.2023.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    static let identifier = "ContactTableViewCell"
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        //label.text = "Janna D'Ark"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
       // label.text = "jan_ka"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        usernameLabel.text = ""
    }
    
    private func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-5)
          
        }
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
    func configure(with model: Contact) {
        self.usernameLabel.text = model.username
        self.nameLabel.text = model.name
    }
    
    func configureComments(with comment: Comment) {
        self.usernameLabel.text = comment.body
        self.nameLabel.text = comment.title
    }
    

}
