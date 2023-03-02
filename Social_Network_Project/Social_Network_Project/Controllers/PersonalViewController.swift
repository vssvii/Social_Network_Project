//
//  PersonalViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 06.02.2023.
//

import UIKit

class PersonalViewController: UIViewController {
    
    // MARK: Variables
    
    let viewModel = PersonalViewModel()
    
    
    
    private enum CellReuseIdentifiers: String {
        case feedPosts
    }
    
    
    lazy var feedsTableView: UITableView = {
        let feedsTableView = UITableView(frame: .zero, style: .grouped)
        feedsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.feedPosts.rawValue)
        feedsTableView.delegate = self
        feedsTableView.dataSource = self
        return feedsTableView
    }()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
    // MARK: Constraints
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(feedsTableView)
        
        feedsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: Extension - Table View

extension PersonalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.feeds.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = viewModel.feeds[indexPath.row]
        let post = feed.post
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.feedPosts.rawValue) as! PostsTableViewCell
        cell.userImageView.image = feed.feedImage
        cell.surnameLabel.text = feed.feedName
        cell.postImageVIew.image = post.image
        cell.postTextLabel.attributedText = makeAttributedString(title: "", subtitle: post.description)
        cell.dateLabel.text = post.date.toString(dateFormat: "MMM d")
        cell.likesLabel.text = "\(post.likes)"
        cell.commentLabel.text = "\(3)"
        // MARK: Like Action
        let tapRecognizer = TapGestureRecognizer(block: { [self] in
            if CoreDataManager.shared.posts.contains( where: { $0.descript == post.description })  {
                presentAlert(title: "", message: "the_post_has_been_already_added".localized)
        } else {
            cell.likeButton.tintColor = .red
            cell.likesLabel.text = "\(post.likes + 1)"
            CoreDataManager.shared.addNewPost(surname: feed.feedName, name: "", description: post.description)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        }
    })
        tapRecognizer.numberOfTapsRequired = 1
        cell.likeButton.isUserInteractionEnabled = true
        cell.likeButton.addGestureRecognizer(tapRecognizer)
        
        // MARK: Open information about post with comments
        let imageTapRecognizer = TapGestureRecognizer(block: { [self] in
            let postVC = PostViewController(userImage: feed.feedImage ?? UIImage(named: "")!, nickName: feed.feedName, job: "", image: post.image ?? UIImage(named: "")!, text: post.description, likesCount: post.likes, date: post.date, comments: post.comments)
            self.navigationController?.pushViewController(postVC, animated: true)
        })
        imageTapRecognizer.numberOfTapsRequired = 1
        cell.postImageVIew.isUserInteractionEnabled = true
        cell.postImageVIew.addGestureRecognizer(imageTapRecognizer)
        //MARK: BookMark Action
        let bookMarkTapRecognizer = TapGestureRecognizer(block: { [self] in
            cell.bookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .highlighted)
            cell.bookMarkButton.tintColor = .red
        })
        bookMarkTapRecognizer.numberOfTapsRequired = 1
        cell.bookMarkButton.isUserInteractionEnabled = true
        cell.bookMarkButton.addGestureRecognizer(bookMarkTapRecognizer)
            return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}
