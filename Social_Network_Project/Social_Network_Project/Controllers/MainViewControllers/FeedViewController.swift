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
    
    
    let viewModel = FeedViewModel()
    
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
            return viewModel.feeds.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = viewModel.feeds[indexPath.row]
        if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.stories.rawValue) as! StoriesTableViewCell
          return cell
        } else {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.feeds.rawValue) as! PostsTableViewCell
            cell.dateLabel.text = feed.date.toString(dateFormat: "MMM d")
            cell.avatarImageView.image = feed.avatarImage
            cell.nameLabel.text = feed.name
            cell.surnameLabel.text = feed.surname
            cell.jobLabel.text = feed.job
            cell.postTextLabel.text = feed.text
            cell.postImageVIew.image = feed.image
            cell.likesLabel.text = "\(feed.likes)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let feed = viewModel.feeds[indexPath.row]
            let friendVC = FriendViewController(nickName: feed.nickName, avatarImage: (feed.avatarImage ?? defaultImage)!, name: feed.name, surname: feed.surname, job: feed.job, gender: feed.gender)
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
