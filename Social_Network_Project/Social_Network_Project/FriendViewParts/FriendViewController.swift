//
//  FriendViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 20.02.2023.
//

import UIKit
import SnapKit
import SideMenu

class FriendViewController: UIViewController {
    
    var nickName: String
    
    var avatarImage: UIImage
    
    var name: String

    var surname: String
    
    var job: String
    
    var gender: String
    
    let viewModel = FriendViewModel()
    
    private enum CellReuseIdentifiers: String {
        case posts
        case photos
    }
    
    
    lazy var postsTableView: UITableView = {
        let postsTableView = UITableView(frame: .zero, style: .grouped)
        postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.posts.rawValue)
        postsTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.photos.rawValue)
        postsTableView.delegate = self
        postsTableView.dataSource = self
        return postsTableView
    }()
    
    init(nickName: String, avatarImage: UIImage, name: String, surname: String, job: String, gender: String) {
        self.nickName = nickName
        self.avatarImage = avatarImage
        self.name = name
        self.surname = surname
        self.job = job
        self.gender = gender
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(openMenu))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
        
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
//    private func setupSideMenu() {
//        editSideMenu.leftSide = false
//        profileSideMenu.leftSide = false
//        SideMenuManager.default.rightMenuNavigationController = profileSideMenu
//        SideMenuManager.default.addPanGestureToPresent(toView: view)
//    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func openMenu() {
        
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

extension FriendViewController: UITableViewDataSource, UITableViewDelegate {
    
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
            return viewModel.sergeiPosts.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = viewModel.sergeiPosts[indexPath.row]
        if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.photos.rawValue) as! PhotosTableViewCell
            cell.rightPointerButton.addTarget(self, action: #selector(openPhotosAction), for: .touchUpInside)
          return cell
        } else {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.posts.rawValue) as! PostsTableViewCell
            cell.avatarImageView.image = avatarImage
            cell.surnameLabel.text = surname
            cell.nameLabel.text = name
            cell.jobLabel.text = job
            cell.postTextLabel.text = post.description
            cell.postImageVIew.image = post.image
            cell.likesLabel.text = "\(post.likes)"
            cell.dateLabel.text = post.date.toString(dateFormat: "MMM d")
            return cell
        }
    }
    
    @objc func openPhotosAction() {
        let photosVC = PhotosViewController()
        navigationController?.pushViewController(photosVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = FriendHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150))
            view.nickNameLabel.text = nickName
            view.nameLabel.text = name
            view.surnameLabel.text = surname
            view.avatarImageView.image = avatarImage
            view.jobLabel.text = job
            view.genderLabel.text = gender
            view.publicationResultLabel.text = "200 публикаций"
            view.subscriptionResultLabel.text = "350 подписок"
            view.subscriberResultLabel.text = "350 подписчиков"
            view.infoLabel.isUserInteractionEnabled = true
            let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openInfoPageAction))
            view.infoLabel.addGestureRecognizer(guestureRecognizer)
            return view
        } else {
            return UIView()
        }
    }
    
    
//    @objc func openEditPage() {
//        present(editSideMenu, animated: true)
//    }
    
    
    @objc func openInfoPageAction() {
        let infoPageVC = InformationViewController(nickName: nickName, name: name, surname: surname, job: job, gender: gender, birth: "17.12.95", city: "Астана")
        navigationController?.pushViewController(infoPageVC, animated: true)
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
