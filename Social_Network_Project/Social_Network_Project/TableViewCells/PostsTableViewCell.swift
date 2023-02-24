//
//  PostTableViewCell.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 12.03.2022.
//

import UIKit
import SnapKit



class PostsTableViewCell: UITableViewCell {
    
    var likedButtonTapped: (() -> Void)?
    
    
    lazy var firstSeparatorLine: UIView = {
        let firstSeparatorLine = UIView()
        firstSeparatorLine.backgroundColor = Tint.gray
        return firstSeparatorLine
    }()
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = Tint.gray
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.layer.borderColor = Tint.gray.cgColor
        dateLabel.layer.borderWidth = 1
        dateLabel.layer.cornerRadius = 10
        dateLabel.textAlignment = .center
        dateLabel.layer.masksToBounds = true
        return dateLabel
    }()
    
    lazy var secondSeparatorLine: UIView = {
        let secondSeparatorLine = UIView()
        secondSeparatorLine.backgroundColor = Tint.gray
        return secondSeparatorLine
    }()
    
    
    var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
    }()

    lazy var surnameLabel: UILabel = {
        let surnameLabel = UILabel()
        surnameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        surnameLabel.textColor = .black
        surnameLabel.numberOfLines = 0
        
        return surnameLabel
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .boldSystemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    lazy var jobLabel: UILabel = {
        let jobLabel = UILabel()
        jobLabel.font = UIFont.boldSystemFont(ofSize: 14)
        jobLabel.textColor = UIColor(hex: "#7E8183")
        
        return jobLabel
    }()
    
    lazy var parametersButton: UIButton = {
        let parametersButton = UIButton()
        parametersButton.setImage(UIImage(named: "menu"), for: .normal)
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
        postTextLabel.lineBreakMode = .byTruncatingTail
        postTextLabel.adjustsFontSizeToFitWidth = false
        return postTextLabel
    }()
    
    private lazy var expandButton: UIButton = {
        let expandButton = UIButton()
        expandButton.setTitleColor(Tint.blue, for: .normal)
        expandButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        expandButton.setTitle("Показать полностью", for:  .normal)
        expandButton.addTarget(self, action: #selector(expandAction), for: .touchUpInside)
        return expandButton
    }()
    
    private var descriptionHeightConstraint: NSLayoutConstraint!
    
    private var expanded: [Bool] = []
    private var descriptionIsExpanded = false {
        didSet {
            if descriptionIsExpanded {
                expandButton.snp.updateConstraints { (make) in
                    make.top.equalTo(postTextLabel.snp.bottom).offset(5)
                }
            } else {
                expandButton.snp.updateConstraints { (make) in
                    make.top.equalTo(postTextLabel.snp.bottom).offset(-5)
                }
            }
        }
    }
    
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
    
    @objc private func likedOnTapped() {
        likedButtonTapped?()
    }
    
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
        
        if let postText = postTextLabel.text {
            guard let attr = try? NSAttributedString(htmlString: postText, font: UIFont.systemFont(ofSize: 15), useDocumentFontSize: false) else { return }
            let str: NSMutableAttributedString = NSMutableAttributedString(attributedString: attr)
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = .byTruncatingTail
            style.paragraphSpacing = 10
            str.addAttribute(.paragraphStyle, value: style, range: _NSRange(location: 0, length: str.length))
            postTextLabel.attributedText = str
        }
        
        if postTextLabel.isTruncated {
            expandButton.isHidden = false
        } else {
            expandButton.isHidden = true
        }
    }
    
    @objc private func expandAction() {
        descriptionIsExpanded.toggle()
        if descriptionIsExpanded {
            descriptionHeightConstraint.isActive = false
            expandButton.setTitle("Скрыть", for: .normal)
        } else {
            descriptionHeightConstraint.isActive = true
            expandButton.setTitle("Показать полностью", for: .normal)
        }
    }
    
    
    
    
    private func setupView() {
        
        addSubview(firstSeparatorLine)
        addSubview(dateLabel)
        addSubview(secondSeparatorLine)
        addSubview(avatarImageView)
        addSubview(surnameLabel)
        addSubview(nameLabel)
        addSubview(jobLabel)
        addSubview(parametersButton)
        addSubview(postView)
        postView.addSubview(verticalLineView)
        postView.addSubview(postTextLabel)
        postView.addSubview(expandButton)
        postView.addSubview(postImageVIew)
        postView.addSubview(separatorLineView)
        postView.addSubview(likesImageView)
        postView.addSubview(likesLabel)
        postView.addSubview(commentsImageView)
        postView.addSubview(commentsLabel)
        postView.addSubview(savedImageView)
        
        
        dateLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(100)
        }
        
        firstSeparatorLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(dateLabel.snp.left).offset(-10)
            make.height.equalTo(1)
        }
        
        secondSeparatorLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.left.equalTo(dateLabel.snp.right).offset(10)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }

        avatarImageView.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(26)
            make.width.height.equalTo(70)
        }
        
        surnameLabel.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(36)
            make.top.equalTo(dateLabel.snp.bottom).offset(36)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
        }
        
        nameLabel.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(36)
            make.top.equalTo(dateLabel.snp.bottom).offset(36)
            make.left.equalTo(surnameLabel.snp.right).offset(6)
        }
        
        jobLabel.snp.makeConstraints { (make) in
            make.top.equalTo(surnameLabel.snp.bottom).offset(6)
            make.left.equalTo(avatarImageView.snp.right).offset(16)
        }
        
        parametersButton.snp.makeConstraints { (make) in
//            make.top.equalToSuperview().offset(36)
            make.top.equalTo(dateLabel.snp.bottom).offset(36)
            make.right.equalToSuperview().offset(-16)
        }
        
        postView.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        
        verticalLineView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(1)
            make.height.equalTo(postTextLabel.snp.height).offset(40)
        }
        
        
        postTextLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(verticalLineView.snp.right).offset(16)
            make.right.equalTo(-16)
        }
        
        descriptionHeightConstraint = postTextLabel.heightAnchor.constraint(equalToConstant: 80)
        descriptionHeightConstraint.isActive = true
        
        expandButton.snp.makeConstraints { (make) in
            make.top.equalTo(postTextLabel.snp.bottom).offset(3)
            make.left.equalTo(verticalLineView.snp.right).offset(16)
//            make.width.equalTo(140)
//            make.height.equalTo(15)
        }
        
        postImageVIew.snp.makeConstraints { (make) in
            make.top.equalTo(expandButton.snp.bottom).offset(50)
            make.left.equalTo(verticalLineView.snp.right).offset(16)
            make.right.equalTo(-16)
            make.height.equalTo(200)
            make.width.equalTo(450)
        }

        separatorLineView.snp.makeConstraints { (make) in
            make.top.equalTo(postImageVIew.snp.bottom).offset(30)
            make.height.equalTo(1)
            make.width.equalTo(postView.snp.width)
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

extension UILabel {
    
    
    var isTruncated: Bool {
        guard let labelText = text else { return false }
        let labelTextSize = (labelText as NSString).boundingRect(with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),options: .usesLineFragmentOrigin,attributes: [NSAttributedString.Key.font: font as Any],context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}

extension NSAttributedString {

    convenience init(htmlString html: String, font: UIFont? = nil, useDocumentFontSize: Bool = true) throws {
            
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let data = html.data(using: .utf8, allowLossyConversion: true)
        guard (data != nil), let fontFamily = font?.familyName, let attr = try? NSMutableAttributedString(data: data!, options: options, documentAttributes: nil) else {
            try self.init(data: data ?? Data(html.utf8), options: options, documentAttributes: nil)
            return
        }
        
        let fontSize: CGFloat? = useDocumentFontSize ? nil : font!.pointSize
        let range = NSRange(location: 0, length: attr.length)
        attr.enumerateAttribute(.font, in: range, options: .longestEffectiveRangeNotRequired) { attrib, range, _ in
            if let htmlFont = attrib as? UIFont {
                let traits = htmlFont.fontDescriptor.symbolicTraits
                var descrip = htmlFont.fontDescriptor.withFamily(fontFamily)
                
                if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0 {
                    descrip = descrip.withSymbolicTraits(.traitBold)!
                }
                
                if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitItalic.rawValue) != 0 {
                    descrip = descrip.withSymbolicTraits(.traitItalic)!
                }
                
                attr.addAttribute(.font, value: UIFont(descriptor: descrip, size: fontSize ?? htmlFont.pointSize), range: range)
            }
        }
        
        self.init(attributedString: attr)
        //execute(attr)
    }

}


