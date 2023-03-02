//
//  FriendHeaderView.swift
//  Social_Network_Project
//
//  Created by Developer on 20.02.2023.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import SideMenu


class FriendHeaderView: UIView {
    
    // MARK: Outlets
    
    
    lazy var nickNameLabel: UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.font = .boldSystemFont(ofSize: 16)
        return nickNameLabel
    }()
    
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.cornerRadius = 35
        return avatarImageView
    }()
    
    lazy var surnameLabel: UILabel = {
        let surnameLabel = UILabel()
        surnameLabel.font = .boldSystemFont(ofSize: 18)
        return surnameLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let surnameLabel = UILabel()
        surnameLabel.font = .boldSystemFont(ofSize: 18)
        return surnameLabel
    }()
    
    lazy var jobLabel: UILabel = {
        let jobLabel = UILabel()
        jobLabel.font = UIFont.systemFont(ofSize: 14)
        jobLabel.textColor = Tint.textGray
        return jobLabel
    }()
    
    lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.font = .systemFont(ofSize: 14)
        return genderLabel
    }()
    
    lazy var birthLabel: UILabel = {
        let birthLabel = UILabel()
        return birthLabel
    }()
    
    lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        return cityLabel
    }()
    
    lazy var infoImageView: UIImageView = {
        let informationImageView = UIImageView()
        informationImageView.image = UIImage(named: "exclamPoint")
        return informationImageView
    }()
    
    lazy var infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.text = "detailed_information".localized
        infoLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return infoLabel
    }()
    
    lazy var messageButton: UIButton = {
        let messageButton = UIButton()
        messageButton.backgroundColor = Tint.oxfordBlue
        messageButton.layer.cornerRadius = 10
        messageButton.setTitle("message".localized, for: .normal)
        messageButton.tintColor = .white
        return messageButton
    }()
    
    lazy var сallButton: UIButton = {
        let сallButton = UIButton()
        сallButton.backgroundColor = Tint.gray
        сallButton.layer.cornerRadius = 10
        сallButton.setTitle("call".localized, for: .normal)
        сallButton.tintColor = .white
        return сallButton
    }()

    
    lazy var publicationResultLabel: UILabel = {
        let publicationResultLabel = UILabel()
        publicationResultLabel.font = UIFont.systemFont(ofSize: 16)
        publicationResultLabel.numberOfLines = 2
        return publicationResultLabel
    }()
    
    lazy var subscriptionResultLabel: UILabel = {
        let subscriptionResultLabel = UILabel()
        subscriptionResultLabel.font = UIFont.systemFont(ofSize: 16)
        subscriptionResultLabel.numberOfLines = 2
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeColorPublication))
        subscriptionResultLabel.isUserInteractionEnabled = true
        subscriptionResultLabel.addGestureRecognizer(tap)
        return subscriptionResultLabel
    }()
    
    @objc func changeColorPublication() {
        subscriptionResultLabel.textColor = Tint.orange
    }
    
    lazy var subscriberResultLabel: UILabel = {
        let subscriberResultLabel = UILabel()
        subscriberResultLabel.font = UIFont.systemFont(ofSize: 16)
        subscriberResultLabel.numberOfLines = 2
        return subscriberResultLabel
    }()
    
    lazy var separatorLineView: UIView = {
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = Tint.textGray
        return separatorLineView
    }()
    
    
    override func draw(_ rect: CGRect) {
        guard UIGraphicsGetCurrentContext() != nil else {
            return
        }
        
        setupView()
    
    }
    
    func editDataProfile() {
        
    }
    
    // MARK: Setup Constraints
    
    private func setupView() {
        
        
        self.addSubview(nickNameLabel)
        self.addSubview(avatarImageView)
        self.addSubview(surnameLabel)
        self.addSubview(nameLabel)
        self.addSubview(jobLabel)
        self.addSubview(infoImageView)
        self.addSubview(infoLabel)
        self.addSubview(messageButton)
        self.addSubview(сallButton)
        self.addSubview(publicationResultLabel)
        self.addSubview(subscriptionResultLabel)
        self.addSubview(subscriberResultLabel)
        self.addSubview(separatorLineView)
        
        
        
        nickNameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(80)
        }
        
        surnameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(21)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(21)
            make.left.equalTo(surnameLabel.snp.right).offset(6)
        }
        
        jobLabel.snp.makeConstraints { (make) in
            make.top.equalTo(surnameLabel.snp.bottom).offset(6)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
        }
        
        infoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(jobLabel.snp.bottom).offset(6)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
        }
        
        infoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobLabel.snp.bottom).offset(6)
            make.left.equalTo(infoImageView.snp.right).offset(6)
        }
        
        messageButton.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(32)
            make.left.equalToSuperview().offset(32)
//            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(45)
            make.width.equalTo(160)
        }
        
        сallButton.snp.makeConstraints { (make) in
            make.top.equalTo(infoLabel.snp.bottom).offset(32)
            make.right.equalToSuperview().offset(-32)
            make.height.equalTo(45)
            make.width.equalTo(160)
        }
        
        subscriptionResultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(messageButton.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
        
        publicationResultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(messageButton.snp.bottom).offset(16)
            make.right.equalTo(subscriptionResultLabel.snp.left).offset(-25)
            make.width.equalTo(100)
        }
        
        subscriberResultLabel.snp.makeConstraints { (make) in
            make.top.equalTo(messageButton.snp.bottom).offset(16)
            make.left.equalTo(subscriptionResultLabel.snp.right).offset(25)
            make.width.equalTo(100)
        }
        
        separatorLineView.snp.makeConstraints { (make) in
            make.top.equalTo(subscriptionResultLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }
    }
}
