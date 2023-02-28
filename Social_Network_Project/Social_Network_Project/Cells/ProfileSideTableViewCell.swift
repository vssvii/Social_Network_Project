//
//  ProfileSideTableViewCell.swift
//  Social_Network_Project
//
//  Created by Developer on 12.02.2023.
//

import UIKit

class ProfileSideTableViewCell: UITableViewCell {

    var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.clipsToBounds = true
        iconImageView.tintColor = .black
        return iconImageView
    }()

    lazy var menuLabel: UILabel = {
        let menuLabel = UILabel()
        menuLabel.font = UIFont.boldSystemFont(ofSize: 14)
        menuLabel.textColor = .black
        menuLabel.numberOfLines = 0
        return menuLabel
    }()
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    
    private func setupView() {
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(menuLabel)
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(17)
        }
        
        menuLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(iconImageView.snp.right).offset(16)
        }
    }
}
