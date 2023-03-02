//
//  PostTableViewCell.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 12.03.2022.


import UIKit
import SnapKit



class PostsTableViewCell: UITableViewCell {
    
    
    private enum UIConstants {
        static let userImageSize: CGFloat = 30
        static let contentInset: CGFloat = 12
        static let userImageTopInset: CGFloat = 6
        static let usernameLabelFontSize: CGFloat = 14
        static let subtitleFontSize: CGFloat = 11
        static let usernameStackToProfileImageOffset: CGFloat = 12
        static let postImageToUserImageOffset: CGFloat = 6
        static let actionsStackHeight: CGFloat = 24
        static let actionsStackToPostImageOffset: CGFloat = 12
        static let actionsStackSpacing: CGFloat = 12
        static let actionsStackToLikesLabelOffset: CGFloat = 12
        static let likesLabelFontSize: CGFloat = 14
        static let commentLabelFontSize: CGFloat = 14
        static let commentToLikesOffset: CGFloat = 12
    }
    
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
    
    
    let userImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = UIConstants.userImageSize / 2
        view.clipsToBounds = true
        return view
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
        expandButton.setTitle("show_in_all".localized, for:  .normal)
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
        let postImageVIew = UIImageView()
        postImageVIew.contentMode = .scaleAspectFill
        postImageVIew.backgroundColor = .black
        var itemSize:CGSize = CGSizeMake(600, 400)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale)
        var imageRect : CGRect = CGRectMake(0, 0, itemSize.width, itemSize.height)
        postImageVIew.image?.draw(in: imageRect)
        postImageVIew.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return postImageVIew
    }()
    
    var separatorLineView: UIView = {
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor(hex: "#7E8183")
        return separatorLineView
    }()

    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        return button
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
            expandButton.setTitle("hide".localized, for: .normal)
        } else {
            descriptionHeightConstraint.isActive = true
            expandButton.setTitle("show_in_all".localized, for: .normal)
        }
    }
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.likesLabelFontSize, weight: .bold)
        return label
    }()

    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.commentLabelFontSize)
        return label
    }()
    
    
    
    
    private func setupView() {

        selectionStyle = .none
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(100)

        }
        
        contentView.addSubview(firstSeparatorLine)
        firstSeparatorLine.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(dateLabel.snp.left).offset(-6)
            make.height.equalTo(1)
        }
        
        contentView.addSubview(secondSeparatorLine)
        secondSeparatorLine.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.left.equalTo(dateLabel.snp.right).offset(6)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(1)
        }
        
        
        contentView.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.size.equalTo(UIConstants.userImageSize)
        }
        
        contentView.addSubview(surnameLabel)
        
        surnameLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.left.equalTo(userImageView.snp.right).offset(16)
        }
        
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(surnameLabel.snp.centerY)
            make.left.equalTo(surnameLabel.snp.right).offset(6)
        }
        
        contentView.addSubview(jobLabel)
        
        jobLabel.snp.makeConstraints { make in
            make.top.equalTo(surnameLabel.snp.bottom).offset(6)
            make.left.equalTo(userImageView.snp.right).offset(16)
        }
        
        contentView.addSubview(parametersButton)
        
        parametersButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(postTextLabel)
        
        postTextLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(expandButton)
        
        expandButton.snp.makeConstraints { make in
            make.top.equalTo(postTextLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(postImageVIew)
        
        postImageVIew.snp.makeConstraints { make in
            make.top.equalTo(expandButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(200)
            make.width.equalTo(340)
        }
        
        contentView.addSubview(likeButton)
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postImageVIew.safeAreaLayoutGuide.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        contentView.addSubview(likesLabel)
        
        likesLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton.snp.centerY)
            make.left.equalTo(likeButton.snp.right).offset(6)
        }
        
        contentView.addSubview(commentButton)
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton.snp.centerY)
            make.left.equalTo(likesLabel.snp.right).offset(16)
        }
        
        contentView.addSubview(commentLabel)
        
        commentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton.snp.centerY)
            make.left.equalTo(commentLabel.snp.right).offset(6)
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


