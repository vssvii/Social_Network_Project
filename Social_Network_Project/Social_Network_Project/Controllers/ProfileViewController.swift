//
//  ProfileViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 03.02.2023.
//

import UIKit
import SnapKit
import SideMenu

class ProfileViewController: UIViewController {
    
    var nickName: String
    
    var name: String

    var surname: String
    
    var job: String
    
    var gender: String
    
    var birth: String
    
    var city: String
    
    let coreManager = CoreDataManager.shared
    
    public var menuDelegate: MenuControllerDelegate?
    
    private var profileSideMenu = SideMenuNavigationController(rootViewController: ProfileSideMenuViewController())
    
    private var editSideMenu = SideMenuNavigationController(rootViewController: EditMenuViewController())
    
    let viewModel = ProfileViewModel()
    
    private enum CellReuseIdentifiers: String {
        case posts
        case photos
    }
    
    
    lazy var postsTableView: UITableView = {
        let postsTableView = UITableView(frame: .zero, style: .grouped)
        postsTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.posts.rawValue)
        postsTableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.photos.rawValue)
        postsTableView.isUserInteractionEnabled = true
        postsTableView.delegate = self
        postsTableView.dataSource = self
        return postsTableView
    }()
    
    init(nickName: String, name: String, surname: String, job: String, gender: String, birth: String, city: String) {
        self.nickName = nickName
        self.name = name
        self.surname = surname
        self.job = job
        self.gender = gender
        self.birth = birth
        self.city = city
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let indexPath = postsTableView.indexPathForSelectedRow else { return
        }
        postsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "list"), style: .done, target: self, action: #selector(openList))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
        
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    private func setupSideMenu() {
        editSideMenu.leftSide = false
        profileSideMenu.leftSide = false
        SideMenuManager.default.rightMenuNavigationController = profileSideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
    }
    
    @objc func openList() {
        present(profileSideMenu, animated: true)
    }
    
    func getFormattedDate(date: Date, format: String) -> String {
            let dateformat = DateFormatter()
            dateformat.dateFormat = format
            return dateformat.string(from: date)
    }

    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(postsTableView)
        
        postsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
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
            return viewModel.posts.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = viewModel.posts[indexPath.row]
        if indexPath.section == 0 {
          let cell = postsTableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.photos.rawValue) as! PhotosTableViewCell
            cell.photos = viewModel.photos
            cell.albums = viewModel.albums
            cell.rightPointerButton.addTarget(self, action: #selector(openPhotosAction), for: .touchUpInside)
          return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseIdentifiers.posts.rawValue) as! PostsTableViewCell
            cell.userImageView.image = UIImage(named: "avatar")
            cell.surnameLabel.text = surname
            cell.nameLabel.text = name
            cell.jobLabel.text = job
            cell.postTextLabel.text = post.description
            cell.postImageVIew.image = post.image
            cell.likesLabel.text = "\(post.likes)"
            cell.dateLabel.text = post.date.toString(dateFormat: "MMM d")
            let tapRecognizer = TapGestureRecognizer(block: { [self] in
                if coreManager.posts.contains( where: { $0.descript == post.description })  {
                    presentAlert(title: "", message: "the_post_has_been_already_added".localized)
            } else {
                cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
                cell.likeButton.tintColor = .red
                self.coreManager.addNewPost(surname: surname, name: name, description: post.description)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
            }
        })
            tapRecognizer.numberOfTapsRequired = 1
            cell.likeButton.isUserInteractionEnabled = true
            cell.likeButton.addGestureRecognizer(tapRecognizer)
            let postTapRecognizer = TapGestureRecognizer(block: { [self] in
                let postVC = PostViewController(userImage: UIImage(named: "avatar") ?? UIImage(named: "")!, nickName: nickName, job: job, image: post.image ?? UIImage(named: "")!, text: post.description, likesCount: post.likes, date: post.date)
                self.navigationController?.pushViewController(postVC, animated: true)
            })
            postTapRecognizer.numberOfTapsRequired = 1
            cell.postImageVIew.isUserInteractionEnabled = true
            cell.postImageVIew.addGestureRecognizer(postTapRecognizer)
            return cell
        }
    }
        
    
    @objc func openPhotosAction() {
        let photosVC = PhotosViewController(photos: viewModel.photos, albums: viewModel.albums)
        navigationController?.pushViewController(photosVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let view = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 150))
            view.avatarImageView.image = UIImage(named: "avatar")
            view.nickName.text = nickName
            view.nameLabel.text = name
            view.surnameLabel.text = surname
            view.jobLabel.text = job
            let publicationLocalized = "publications".localized
            view.publicationResultLabel.text = "596 \(publicationLocalized)"
            let subscriptionLocalized = "subscriptions".localized
            view.subscriptionResultLabel.text = "867 \(subscriptionLocalized)"
            let subscribersLocalized = "subscribers".localized
            view.subscriberResultLabel.text = "687 \(subscribersLocalized)"
            view.editButton.addTarget(self, action: #selector(openEditPage), for: .touchUpInside)
            view.infoLabel.isUserInteractionEnabled = true
            let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openInfoPageAction))
            view.infoLabel.addGestureRecognizer(guestureRecognizer)
            return view
        } else {
            return UIView()
        }
    }
    
    
    @objc func openEditPage() {
        present(editSideMenu, animated: true)
    }
    
    
    @objc func openInfoPageAction() {
        let infoPageVC = InformationViewController(nickName: nickName, name: name, surname: surname, job: job, gender: gender, birth: birth, city: city)
        navigationController?.pushViewController(infoPageVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 120
        } else {
            return 480
        }
    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return 120
//        } else {
//            return 650
//        }
//
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 420
        } else {
            return 0
        }
    }
}

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: String)
}
