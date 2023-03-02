//
//  SavedPostsViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 03.02.2023.
//

import UIKit
import SnapKit

class LikedPostsViewController: UIViewController {

    
    let coreManager = CoreDataManager.shared
    
    private enum CellReuseIdentifiers: String {
        case likedPosts
    }

    
    private lazy var likedPostsTableView: UITableView = {
        let likedPostsTableView = UITableView(frame: .zero, style: .grouped)
        likedPostsTableView.register(LikedPostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.likedPosts.rawValue)
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
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "delete_all".localized, style: .plain, target: self, action: #selector(deleteAll))
        navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    @objc func refreshTableView() {
        self.likedPostsTableView.reloadData()
    }
    
    @objc func deleteAll() {
        coreManager.deleteAll()
        coreManager.posts = []
        likedPostsTableView.reloadData()
    }
    
    
    private func setupView() {
        view.backgroundColor = .white
        title = "favourite_posts".localized
        
        view.addSubview(likedPostsTableView)
        
        
        likedPostsTableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension LikedPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.likedPosts.rawValue) as! LikedPostsTableViewCell
        let post = coreManager.posts[indexPath.row]
        if let surname = post.surname, let name = post.name {
            cell.authorLabel.text = "\(String(describing: surname)) \(String(describing: name))"
        }
        cell.descriptionLabel.text = post.descript
        let tapRecognizer = TapGestureRecognizer(block: { [self] in
            let alert = UIAlertController(title: "deleting_a_post".localized, message: "want_delete_post".localized, preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "cancel".localized, style: UIAlertAction.Style.default, handler: { _ in
//                            Cancel Action
                        }))
            alert.addAction(UIAlertAction(title: "delete".localized,
                                                      style: UIAlertAction.Style.destructive,
                                                      handler: {(_: UIAlertAction!) in
                                self.coreManager.deletePosts(post: post)
                            tableView.reloadData()
                        }))
            self.present(alert, animated: true, completion: nil)
        })
        tapRecognizer.numberOfTapsRequired = 1
        cell.deleteButton.isUserInteractionEnabled = true
        cell.deleteButton.addGestureRecognizer(tapRecognizer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
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

