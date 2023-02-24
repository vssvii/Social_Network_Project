//
//  FeedViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 06.02.2023.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    private var tableViewHeightConstraint: NSLayoutConstraint!
    private var descriptionHeightConstraint: NSLayoutConstraint!
    
    private enum CellReuseIdentifiers: String {
        case feeds
        case stories
    }
    
    
    let viewModel = FriendViewModel()
    
    let defaultImage = UIImage(named: "")
    
    lazy var feedTableView: UITableView = {
        let feedTableView = UITableView(frame: .zero, style: .grouped)
        feedTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.feeds.rawValue)
        feedTableView.register(StoriesTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.stories.rawValue)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        return feedTableView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
    
    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(feedTableView)
        
        feedTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.friends.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = viewModel.friends[indexPath.row]
        if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.stories.rawValue) as! StoriesTableViewCell
          return cell
        } else {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.feeds.rawValue) as! PostsTableViewCell
            cell.dateLabel.text = friend.date.toString(dateFormat: "MMM d")
            cell.avatarImageView.image = friend.avatarImage
            cell.nameLabel.text = friend.name
            cell.surnameLabel.text = friend.surname
            cell.jobLabel.text = friend.job
            cell.postTextLabel.text = friend.text
            cell.postImageVIew.image = friend.image
            cell.likesLabel.text = "\(friend.likes)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let friend = viewModel.friends[indexPath.row]
            let friendVC = FriendViewController(nickName: friend.nickName, avatarImage: (friend.avatarImage ?? defaultImage)!, name: friend.name, surname: friend.surname, job: friend.job, gender: friend.gender, publicationResult: friend.publicationResult, subscriptionResult: friend.subscriptionResult, subscriberResult: friend.subscriberResult, posts: friend.posts, photos: friend.photos, albums: friend.albums)
            navigationController?.pushViewController(friendVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 630
        }
    }
}
