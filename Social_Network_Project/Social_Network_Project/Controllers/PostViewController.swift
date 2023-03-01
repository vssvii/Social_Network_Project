//
//  PostViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 27.02.2023.
//

import UIKit
import SnapKit

class PostViewController: UIViewController {
    
    let coreManager = CoreDataManager.shared
    
    var userImage: UIImage
    
    var nickName: String
    
    var job: String
    
    var image: UIImage
    
    var text: String
    
    var likesCount: Int
    
    var commentsCount: Int
    
    
    let userImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    lazy var nickNameLabel: UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nickNameLabel.textColor = .black
        nickNameLabel.numberOfLines = 0
        
        return nickNameLabel
    }()
    
    lazy var jobLabel: UILabel = {
        let jobLabel = UILabel()
        jobLabel.font = UIFont.boldSystemFont(ofSize: 14)
        jobLabel.textColor = UIColor(hex: "#7E8183")
        
        return jobLabel
    }()
    
    lazy var postImageView: UIImageView = {
        let postImageView = UIImageView()
        return postImageView
    }()
    
    lazy var postTextLabel: UILabel = {
        let postTextLabel = UILabel()
        postTextLabel.numberOfLines = 0
        postTextLabel.lineBreakMode = .byTruncatingTail
        postTextLabel.adjustsFontSizeToFitWidth = false
        return postTextLabel
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(likedAction), for: .touchUpInside)
        return button
    }()
    
    @objc func likedAction() {
        let tapRecognizer = TapGestureRecognizer(block: { [self] in
            if coreManager.posts.contains( where: { $0.descript == text })  {
                presentAlert(title: "", message: "the_post_has_been_already_added".localized)
        } else {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
            likeButton.tintColor = .red
            self.coreManager.addNewPost(surname: nickName, name: "", description: text)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        }
    })
        tapRecognizer.numberOfTapsRequired = 1
        likeButton.isUserInteractionEnabled = true
        likeButton.addGestureRecognizer(tapRecognizer)
    }
    
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
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()

    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let bookMarkButton: UIButton = {
        let bookMarkButton = UIButton(type: .system)
        bookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookMarkButton.tintColor = .black
        return bookMarkButton
    }()
    
    private let separatorLineView: UIView = {
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = Tint.gray
        return separatorLineView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        configure()
        
        setNavigationBar()

    }
    
    init(userImage: UIImage, nickName: String, job: String, image: UIImage, text: String, likesCount: Int, commentsCount: Int) {
        self.userImage = userImage
        self.nickName = nickName
        self.job = job
        self.image = image
        self.text = text
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = Tint.orange
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configure() {
        
        userImageView.image = userImage
        nickNameLabel.text = nickName
        jobLabel.text = job
        postImageView.image = image
        postTextLabel.text = text
        likesLabel.text = "\(likesCount)"
        commentLabel.text = "\(commentsCount)"
    }
    
    private func setupView() {
        
        title = "post".localized
        view.backgroundColor = .white
        
        view.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.size.equalTo(30)
        }
        
        let usernameStack = UIStackView()
        usernameStack.axis = .vertical
        usernameStack.addArrangedSubview(nickNameLabel)
        usernameStack.addArrangedSubview(jobLabel)
        view.addSubview(usernameStack)
        usernameStack.snp.makeConstraints { make in
            make.centerY.equalTo(userImageView)
            make.leading.equalTo(userImageView.snp.trailing).offset(12)
        }
        
        view.addSubview(postImageView)
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(usernameStack.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(212)
            make.width.equalTo(344)
        }
        
        view.addSubview(postTextLabel)

        postTextLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        view.addSubview(likeButton)
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postTextLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        view.addSubview(likesLabel)
        
        likesLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton.snp.centerY)
            make.left.equalTo(likeButton.snp.right).offset(6)
        }
        
        view.addSubview(commentButton)
        
        commentButton.snp.makeConstraints { make in
            make.centerY.equalTo(likesLabel.snp.centerY)
            make.left.equalTo(likesLabel.snp.right).offset(10)
        }
        
        view.addSubview(commentLabel)
        
        commentLabel.snp.makeConstraints { make in
            make.centerY.equalTo(commentButton.snp.centerY)
            make.left.equalTo(commentButton.snp.right).offset(6)
        }
        
        view.addSubview(bookMarkButton)
        
        bookMarkButton.snp.makeConstraints { make in
            make.centerY.equalTo(commentButton.snp.centerY)
            make.right.equalToSuperview().offset(-16)
        }
        
        view.addSubview(separatorLineView)
        
        separatorLineView.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(16)
            make.height.equalTo(1)
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
        }
        
//        view.addSubview(likesLabel)
//        likesLabel.snp.makeConstraints { make in
//            make.leading.equalTo(likeButton.snp.trailing).offset(6)
//            make.centerY.equalTo(likeButton.snp.centerY)
//        }
//        commentButton.snp.makeConstraints { make in
//            make.left.equalTo(likesLabel.snp.right).offset(6)
//        }
//        view.addSubview(commentLabel)
//        commentLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(likesLabel.snp.trailing).offset(6)
//            make.top.equalTo(likesLabel.snp.bottom).offset(12)
//            make.bottom.equalToSuperview().inset(12)
//        }
    }

}
