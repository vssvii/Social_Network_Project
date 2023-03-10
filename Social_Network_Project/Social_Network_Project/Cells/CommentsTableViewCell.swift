//
//  CommentsTableViewCell.swift
//  Social_Network_Project
//
//  Created by Developer on 01.03.2023.
//

import UIKit
import SnapKit
import ExpyTableView

//MARK: Used Table View Classes

class CommentsTableViewCell: UITableViewCell, ExpyTableViewHeaderCell {
    
    // MARK: Outlets
    
    lazy var userImageView: UIImageView = {
        let userImageView = UIImageView()
        userImageView.layer.cornerRadius = 15
        userImageView.clipsToBounds = true
        return userImageView
    }()
    
    lazy var nickLabel: UILabel = {
        let nickLabel = UILabel()
        nickLabel.textColor = Tint.orange
        nickLabel.font = .boldSystemFont(ofSize: 12)
        return nickLabel
    }()
    
    lazy var commentLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.font = .systemFont(ofSize: 12)
        commentLabel.textColor = Tint.textGray
        return commentLabel
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = Tint.textGray
        dateLabel.font = .systemFont(ofSize: 12)
        return dateLabel
    }()
    
    lazy var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(systemName: "heart")
        heartImageView.tintColor = .black
        return heartImageView
    }()
    
    lazy var responseLabel: UILabel = {
        let responseLabel = UILabel()
        responseLabel.text = "Ответить"
        responseLabel.font = .boldSystemFont(ofSize: 12)
        return responseLabel
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)

        setupView()

    }
    
    // MARK: Setup Constraints
    
    func setupView() {

        contentView.backgroundColor = .white

        contentView.addSubview(userImageView)
        contentView.addSubview(nickLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(heartImageView)
        contentView.addSubview(responseLabel)

        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.size.equalTo(30)
        }

        nickLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(userImageView.snp.right).offset(6)
        }

        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nickLabel.snp.bottom).offset(6)
            make.left.equalTo(userImageView.snp.right).offset(6)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(6)
            make.left.equalTo(userImageView.snp.right).offset(6)
        }

        heartImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(16)
        }

        responseLabel.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(6)
            make.right.equalToSuperview().offset(-16)
        }


    }
    
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            hideSeparator()
//            arrowDown(animated: !cellReuse)
            
        case .willCollapse:
            print("WILL COLLAPSE")
//            arrowRight(animated: !cellReuse)
            
        case .didExpand:
            print("DID EXPAND")
            
        case .didCollapse:
            showSeparator()
            print("DID COLLAPSE")
        }
    }
    
    private func arrowDown(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) {
            self.heartImageView.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        }
    }

    private func arrowRight(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) {
            self.heartImageView.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
}

class SpecificationTableViewCell: UITableViewCell {
    
    
    // MARK: Outlets
    
    lazy var userImageView: UIImageView = {
        let userImageView = UIImageView()
        userImageView.layer.cornerRadius = 15
        userImageView.clipsToBounds = true
        return userImageView
    }()
    
    lazy var nickLabel: UILabel = {
        let nickLabel = UILabel()
        nickLabel.textColor = Tint.orange
        nickLabel.font = .boldSystemFont(ofSize: 12)
        return nickLabel
    }()
    
    lazy var commentAnswerLabel: UILabel = {
        let commentLabel = UILabel()
        commentLabel.font = .systemFont(ofSize: 12)
        commentLabel.textColor = Tint.textGray
        return commentLabel
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = Tint.textGray
        dateLabel.font = .systemFont(ofSize: 12)
        return dateLabel
    }()
    
    lazy var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(systemName: "heart")
        heartImageView.tintColor = .black
        return heartImageView
    }()
    
    lazy var responseLabel: UILabel = {
        let responseLabel = UILabel()
        responseLabel.text = "Ответить"
        responseLabel.font = .boldSystemFont(ofSize: 12)
        return responseLabel
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
        
        contentView.backgroundColor = .white

        contentView.addSubview(userImageView)
        contentView.addSubview(nickLabel)
        contentView.addSubview(commentAnswerLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(heartImageView)
        contentView.addSubview(responseLabel)

        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(32)
            make.size.equalTo(30)
        }

        nickLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(userImageView.snp.right).offset(6)
        }

        commentAnswerLabel.snp.makeConstraints { make in
            make.top.equalTo(nickLabel.snp.bottom).offset(6)
            make.left.equalTo(userImageView.snp.right).offset(6)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(commentAnswerLabel.snp.bottom).offset(6)
            make.left.equalTo(userImageView.snp.right).offset(6)
        }

        heartImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.height.width.equalTo(15)
        }

        responseLabel.snp.makeConstraints { make in
            make.top.equalTo(commentAnswerLabel.snp.bottom).offset(6)
            make.right.equalToSuperview().offset(-16)
        }
    }
}

class SeparatorTableViewCell: UITableViewCell {}

extension UITableViewCell {

    func showSeparator() {
        DispatchQueue.main.async {
            self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func hideSeparator() {
        DispatchQueue.main.async {
            self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
        }
    }
}
