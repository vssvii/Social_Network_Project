//
//  LikedPostsTableViewCell.swift
//  Navigation_2
//
//  Created by Developer on 16.11.2022.
//

import UIKit
import SnapKit

class LikedPostsTableViewCell: UITableViewCell {
    
    private lazy var likedImageView: UIImageView = {
        let likedImageView = UIImageView()
        likedImageView.image = UIImage(systemName: "heart.fill")
        likedImageView.tintColor = .red
        return likedImageView
    }()
    
    public lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        
        authorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 2
        
        return authorLabel
    }()
    
    public lazy var descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 0
        
        descriptionLabel.textColor = .black
        
        return descriptionLabel
    }()
    
    lazy var deleteButton: UIButton = {
        let deleteButton = UIButton()
        deleteButton.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        deleteButton.tintColor = .red
        return deleteButton
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(authorLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likedImageView)
        contentView.addSubview(deleteButton)
        
        likedImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(30)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalTo(likedImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)

        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp.bottom).offset(16)
            make.left.equalTo(likedImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    
    public func update(author: String, description: String) {
        authorLabel.text = author
        descriptionLabel.text = description
    }

}
