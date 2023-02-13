//
//  FeedViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 06.02.2023.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    private enum CellReuseIdentifiers: String {
        case feeds
    }
    
    
    let viewModel = FeedViewModel()
    
    
    lazy var feedTableView: UITableView = {
        let feedTableView = UITableView(frame: .zero, style: .grouped)
        feedTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.feeds.rawValue)
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feed = viewModel.feeds[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.feeds.rawValue) as! PostsTableViewCell
        cell.avatarImageView.image = feed.avatarImage
        cell.authorLabel.text = feed.authorFullName
        cell.jobLabel.text = feed.job
        cell.postTextLabel.text = feed.text
        cell.postImageVIew.image = feed.image
        cell.likesLabel.text = "\(feed.likes)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}
