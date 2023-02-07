//
//  ProfileViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 03.02.2023.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private enum CellReuseIdentifiers: String {
        case posts
        case photos
    }
    
    var posts: [Post] = [Post(description: "В итоге исследователи выделили три главные черты, характеризующие личность слона: внимательность (насколько хорошо животное взаимодействует с окружающей средой), социальность (как животное взаимодействует с сородичами и людьми) и агрессивность (как часто особь проявляет агрессивное поведение в отношении сородичей и людей).", image: UIImage(named: "elephant"), likes: 180),
    Post(description: "Apple выпустила первый SwiftUI в 2019 году, предлагая тем самым новый подход создания приложений в декларативном стиле. SwiftUI 4.0, представленный этим летом на WWDC 2022 вместе с iOS 16 и macOS 13 включает в себя много нововведений для более качественных и универсальных приложений под разные платформы Apple с меньшим количеством кода.", image: UIImage(named: "swiftUI"), likes: 300)]
    
    
    
    lazy var postsTableView: UITableView = {
        let postsTableView = UITableView(frame: .zero, style: .grouped)
        postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.posts.rawValue)
        postsTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.photos.rawValue)
        postsTableView.delegate = self
        postsTableView.dataSource = self
        return postsTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "list"), style: .done, target: self, action: #selector(openList))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
    }
    
    @objc func openList() {
        print("opened")
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(postsTableView)
        
        postsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        if tableView == postsTableView {
            count = 2
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.photos.rawValue) as! PhotosTableViewCell
            cell.rightPointerButton.addTarget(self, action: #selector(openPhotosAction), for: .touchUpInside)
          return cell
        } else {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.posts.rawValue) as! PostsTableViewCell
            cell.avatarImageView.image = UIImage(named: "avatar")
            cell.authorLabel.text = "Асайбулдаев Ибрагим"
            cell.jobLabel.text = "iOS разработчик"
            cell.postTextLabel.text = post.description
            cell.postImageVIew.image = post.image
            cell.likesLabel.text = "\(post.likes)"
              return cell
        }
    }
    
    @objc func openPhotosAction() {
        let photosVC = PhotosViewController()
        navigationController?.pushViewController(photosVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150))
            return view
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 620
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 420
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Мои записи"
    }
}
