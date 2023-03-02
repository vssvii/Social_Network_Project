//
//  PostViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 27.02.2023.
//

import UIKit
import SnapKit
import ExpyTableView


// MARK: Information about post with comments

class PostViewController: UIViewController {
    
    private enum CellReuseIdentifiers: String {
        case comments
        case buy
        case specification
    }
    
    let coreManager = CoreDataManager.shared
    
    var userImage: UIImage
    
    var nickName: String
    
    var job: String
    
    var image: UIImage
    
    var text: String
    
    var likesCount: Int
    
    var date: Date
    
    var comments: [[String]]
    
    
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
        return button
    }()
    
    func likedAction() {
        let tapRecognizer = TapGestureRecognizer(block: { [self] in
            if coreManager.posts.contains( where: { $0.descript == text })  {
                presentAlert(title: "", message: "the_post_has_been_already_added".localized)
        } else {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
            likeButton.tintColor = .red
            likesLabel.text = "\(likesCount + 1)"
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
    
    private lazy var commentsTableView: ExpyTableView = {
        let commentsTableView = ExpyTableView()
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        commentsTableView.rowHeight = UITableView.automaticDimension
        commentsTableView.estimatedRowHeight = 44
        commentsTableView.expandingAnimation = .fade
        commentsTableView.collapsingAnimation = .fade
        commentsTableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.comments.rawValue)
        commentsTableView.register(SeparatorTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.buy.rawValue)
        commentsTableView.register(SpecificationTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.specification.rawValue)
        commentsTableView.tableFooterView = UIView()
        return commentsTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        configure()
        
        setNavigationBar()
        
        likedAction()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func orientationDidChange() {
        switch UIDevice.current.orientation {
        case .portrait, .portraitUpsideDown, .landscapeLeft, .landscapeRight:
            commentsTableView.reloadSections(IndexSet(Array(commentsTableView.expandedSections.keys)), with: .none)
        default:break
        }
    }

    
    init(userImage: UIImage, nickName: String, job: String, image: UIImage, text: String, likesCount: Int, date: Date, comments: [[String]]) {
        self.userImage = userImage
        self.nickName = nickName
        self.job = job
        self.image = image
        self.text = text
        self.likesCount = likesCount
        self.date = date
        self.comments = comments
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
        commentLabel.text = "\(comments.count)"
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
        
        view.addSubview(commentsTableView)
        
        commentsTableView.snp.makeConstraints { make in
            make.top.equalTo(separatorLineView.snp.bottom).offset(6)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}


extension PostViewController: ExpyTableViewDataSource {
    
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
          withIdentifier: CellReuseIdentifiers.comments.rawValue) as! CommentsTableViewCell
        cell.commentLabel.text = comments[section].first!
        cell.userImageView.image = userImage
        cell.nickLabel.text = nickName
        cell.dateLabel.text = date.toString(dateFormat: "MMM d")
        let tapRecognizer = TapGestureRecognizer(block: { [self] in
            cell.heartImageView.image = UIImage(systemName: "heart.fill")
    })
        tapRecognizer.numberOfTapsRequired = 1
        cell.heartImageView.isUserInteractionEnabled = true
        cell.heartImageView.addGestureRecognizer(tapRecognizer)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.showSeparator()
        return cell
    }
}


extension PostViewController: ExpyTableViewDelegate {
    
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            
        case .willCollapse:
            print("WILL COLLAPSE")
            
        case .didExpand:
            print("DID EXPAND")
            
        case .didCollapse:
            print("DID COLLAPSE")
        }
    }
}


extension PostViewController {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section % 3 == 0) ? "\(comments.count) комментария" : nil
    }
}

extension PostViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        print("DID SELECT row: \(indexPath.row), section: \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK: UITableView Data Source Methods
extension PostViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Row count for section \(section) is \(comments[section].count)")
        return comments[section].count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            let cell = tableView.dequeueReusableCell(
              withIdentifier: CellReuseIdentifiers.buy.rawValue) as! SeparatorTableViewCell
            cell.layoutMargins = UIEdgeInsets.zero
            cell.showSeparator()
            return cell

        }else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseIdentifiers.specification.rawValue) as! SpecificationTableViewCell
            cell.commentAnswerLabel.text = (comments[indexPath.section])[indexPath.row]
            cell.userImageView.image = userImage
            cell.nickLabel.text = nickName
            cell.dateLabel.text = date.toString(dateFormat: "MMM d")
            let tapRecognizer = TapGestureRecognizer(block: { [self] in
                cell.heartImageView.image = UIImage(systemName: "heart.fill")
            })
            tapRecognizer.numberOfTapsRequired = 1
            cell.heartImageView.isUserInteractionEnabled = true
            cell.heartImageView.addGestureRecognizer(tapRecognizer)
            cell.layoutMargins = UIEdgeInsets.zero
            cell.hideSeparator()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
