//
//  PersonalViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 06.02.2023.
//

import UIKit

class PersonalViewController: UIViewController {
    
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
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
        cell.postTextLabel.text = post.description
        cell.dateLabel.text = post.date.toString(dateFormat: "MMM d")
        let imageTapRecognizer = TapGestureRecognizer(block: { [self] in
            let postVC = PostViewController(userImage: feed.feedImage ?? UIImage(named: "")!, nickName: feed.feedName, job: "", image: post.image ?? UIImage(named: "")!, text: post.description, likesCount: post.likes, date: post.date, comments: post.comments)
            self.navigationController?.pushViewController(postVC, animated: true)
        })
        imageTapRecognizer.numberOfTapsRequired = 1
        cell.postImageVIew.isUserInteractionEnabled = true
        cell.postImageVIew.addGestureRecognizer(imageTapRecognizer)
            return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
}
