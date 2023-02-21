//
//  SavedPostsViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 03.02.2023.
//

import UIKit
import SnapKit

class SavedPostsViewController: UIViewController {
    
    var likedPosts: [Post] = []
    
    private enum CellReuseIdentifiers: String {
        case likedPosts
    }
    
    private lazy var likedPostsLabel: UILabel = {
        let likedPostsLabel = UILabel()
        likedPostsLabel.textColor = .blue
        likedPostsLabel.text = "double_click"
        likedPostsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        return likedPostsLabel
    }()

    
    private lazy var likedPostsTableView: UITableView = {
        let likedPostsTableView = UITableView(frame: .zero, style: .grouped)
        likedPostsTableView.register(SavedPostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.likedPosts.rawValue)
        likedPostsTableView.delegate = self
        likedPostsTableView.dataSource = self
        return likedPostsTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        navigationItems()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshTableView), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
    private func navigationItems() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "delete_all", style: .plain, target: self, action: #selector(deleteAll))
        navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    @objc func refreshTableView() {
        self.likedPostsTableView.reloadData()
    }
    
    @objc func deleteAll() {
        likedPostsTableView.reloadData()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "favourite_posts"
        
        view.addSubview(likedPostsLabel)
        view.addSubview(likedPostsTableView)
        
        likedPostsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.centerX.equalToSuperview()
        }
        
        likedPostsTableView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(likedPostsLabel.snp.bottom).offset(16)
        }
    }
}

extension SavedPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.likedPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.likedPosts.rawValue) as! SavedPostsTableViewCell
        let post = likedPosts[indexPath.row]
        cell.descriptionLabel.text = post.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = likedPosts[indexPath.row]
        let tapRecognizer = TapGestureRecognizer(block: { [self] in
            let alert = UIAlertController(title: "deleting_post", message: "want_delete_post", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.default, handler: { _ in
                            //Cancel Action
                        }))
            alert.addAction(UIAlertAction(title: "delete",
                                                      style: UIAlertAction.Style.destructive,
                                                      handler: {(_: UIAlertAction!) in
//                            self.coreManager.deletePosts(post: post)
                            tableView.reloadData()
                        }))
                        self.present(alert, animated: true, completion: nil)
        })
        tapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapRecognizer)
    }


    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

class TapGestureRecognizer: UITapGestureRecognizer {
    private var closure: (() -> ())?

    init() {
        super.init(target: TapGestureRecognizer.self, action: #selector(runAction))
        self.removeTarget(TapGestureRecognizer.self, action: #selector(runAction))
        self.addTarget(self, action: #selector(runAction))
    }

    convenience init(block: @escaping (() -> Void)) {
        self.init()
        closure = block
//        view.addGestureRecognizer(self)
    }

    @objc func runAction() {
        print("executed")
        if closure == nil { return }
        closure!()
    }
}

