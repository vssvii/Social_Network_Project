//
//  ContactsTableViewCell.swift
//  Social_Network_Project
//
//  Created by Developer on 01.03.2023.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    lazy var contactLabel: UILabel = {
        let contactLabel = UILabel()
        contactLabel.font = .boldSystemFont(ofSize: 14)
        contactLabel.textColor = .black
        return contactLabel
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupView()

    }
    
    // MARK: Setup Constraints
    
    private func setupView() {
        
        contentView.addSubview(contactLabel)
        
        contactLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}
