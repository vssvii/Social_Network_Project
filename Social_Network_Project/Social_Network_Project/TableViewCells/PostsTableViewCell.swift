//
//  PostTableViewCell.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 12.03.2022.
//

import UIKit
import SnapKit

class PostsTableViewCell: UITableViewCell {

    
    var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.cornerRadius = 30
        return avatarImageView
    }()

    lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = UIFont.boldSystemFont(ofSize: 16)
        authorLabel.textColor = .black
        authorLabel.numberOfLines = 0
        
        return authorLabel
    }()
    
    lazy var jobLabel: UILabel = {
        let jobLabel = UILabel()
        jobLabel.font = UIFont.boldSystemFont(ofSize: 14)
        jobLabel.textColor = UIColor(hex: "#7E8183")
        
        return jobLabel
    }()
    
    lazy var parametersButton: UIButton = {
        let parametersButton = UIButton()
        parametersButton.setImage(UIImage(systemName: "increase.indent"), for: .normal)
        parametersButton.tintColor = UIColor(hex: "#FF9E45")
        return parametersButton
    }()
    
    lazy var settingsImageView: UIImageView = {
        let settingsImageView = UIImageView()
        return settingsImageView
    }()
    
    lazy var postView: UIView = {
        let postView = UIView()
        postView.backgroundColor = UIColor(hex: "#F5F3EE")
        return postView
    }()
    
    lazy var verticalLineView: UIView = {
        let verticalLineView = UIView()
        verticalLineView.backgroundColor = UIColor(hex: "#7E8183")
        return verticalLineView
    }()
    
    lazy var postTextLabel: UILabel = {
        let postTextLabel = UILabel()
        postTextLabel.numberOfLines = 0
        return postTextLabel
    }()
    
    lazy var postImageVIew: UIImageView = {
        let postView = UIImageView()
        postView.contentMode = .scaleAspectFill
        postView.backgroundColor = .black
        return postView
    }()
    
    var separatorLineView: UIView = {
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(hex: "#7E8183")
        return separatorLineView
    }()

    
    lazy var likesImageView: UIImageView = {
        let likesImageView = UIImageView()
        likesImageView.image = UIImage(named: "like")
        return likesImageView
    }()
    
    lazy var likesLabel : UILabel = {
        let likesLabel = UILabel()
        likesLabel.font = UIFont.systemFont(ofSize: 16)
        likesLabel.textColor = .black
        
        return likesLabel
    }()
    
    lazy var commentsImageView: UIImageView = {
        let commentsImageView = UIImageView()
        return commentsImageView
    }()
    
    lazy var commentsLabel : UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.font = UIFont.systemFont(ofSize: 16)
        viewsLabel.textColor = .black
        
        return viewsLabel
    }()

    
    lazy var savedImageView: UIImageView = {
        let savedImageView = UIImageView()
        return savedImageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    
    private func setupView() {
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(jobLabel)
        contentView.addSubview(parametersButton)
        contentView.addSubview(postView)
        postView.addSubview(verticalLineView)
        postView.addSubview(postTextLabel)
        postView.addSubview(postImageVIew)
        postView.addSubview(separatorLineView)
        postView.addSubview(likesImageView)
        postView.addSubview(likesLabel)
        postView.addSubview(commentsImageView)
        postView.addSubview(commentsLabel)
        postView.addSubview(savedImageView)
        
        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(26)
            make.left.equalToSuperview().offset(26)
            make.width.height.equalTo(70)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(36)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
        }
        
        jobLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp.bottom).offset(6)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
        }
        
        parametersButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(36)
            make.right.equalToSuperview().offset(-16)
        }
        
        postView.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        verticalLineView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(1)
            make.height.equalTo(400)
        }
        
        
        postTextLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(verticalLineView.snp.right).offset(16)
            make.right.equalTo(-16)
        }
        
        postImageVIew.snp.makeConstraints { (make) in
            make.top.equalTo(postTextLabel.snp.bottom).offset(25)
            make.left.equalTo(verticalLineView.snp.right).offset(16)
            make.right.equalTo(-16)
            make.height.width.equalTo(150)
        }
        
        separatorLineView.snp.makeConstraints { (make) in
            make.top.equalTo(postImageVIew.snp.bottom).offset(30)
            make.height.equalTo(1)
            make.left.equalTo(verticalLineView.snp.right).offset(16)
            make.right.equalTo(-16)
        }
        
        likesImageView.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLineView.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.height.width.equalTo(20)
        }
        
        likesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLineView.snp.bottom).offset(16)
            make.left.equalTo(likesImageView.snp.right).offset(6)
        }
    }
        
        

}
