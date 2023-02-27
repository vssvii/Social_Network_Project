//
//  FeedViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 06.02.2023.
//

import UIKit
import SnapKit

fileprivate let isClearCacheEnabled = true
internal var isDeleteSnapEnabled = true

class FeedViewController: UIViewController {
    
    
    private var _view: StoriesHomeView{return view as! StoriesHomeView}
    private var storiesViewModel: StoriesHomeViewModel = StoriesHomeViewModel()
    
    private var tableViewHeightConstraint: NSLayoutConstraint!
    private var descriptionHeightConstraint: NSLayoutConstraint!
    
    private enum CellReuseIdentifiers: String {
        case feeds
        case addStory
        case listStory
    }
    
    
    let friendViewModel = FriendViewModel()
    
    let defaultImage = UIImage(named: "")
    
    lazy var layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        return flowLayout
    }()
    
    lazy var storiesCollectionView: UICollectionView = {
        let storiesCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        storiesCollectionView.backgroundColor = .white
        storiesCollectionView.showsVerticalScrollIndicator = false
        storiesCollectionView.showsHorizontalScrollIndicator = false
        storiesCollectionView.register(IGStoryListCell.self, forCellWithReuseIdentifier: CellReuseIdentifiers.listStory.rawValue)
        storiesCollectionView.register(IGAddStoryCell.self, forCellWithReuseIdentifier: CellReuseIdentifiers.addStory.rawValue)
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        return storiesCollectionView
    }()
    
    lazy var feedTableView: UITableView = {
        let feedTableView = UITableView(frame: .zero, style: .grouped)
        feedTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.feeds.rawValue)
        feedTableView.delegate = self
        feedTableView.dataSource = self
        return feedTableView
    }()
    
//    override func loadView() {
//        super.loadView()
//        view = StoriesHomeView(frame: UIScreen.main.bounds)
//        _view.collectionView.delegate = self
//        _view.collectionView.dataSource = self
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override var navigationItem: UINavigationItem {
//        let navigationItem = UINavigationItem()
//        navigationItem.titleView = UIImageView(image: UIImage(named: "icInstaLogo"))
//        if isClearCacheEnabled {
//            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear Cache", style: .done, target: self, action: #selector(clearImageCache))
//            navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 203.0/255, green: 69.0/255, blue: 168.0/255, alpha: 1.0)
//        }
//        navigationItem.rightBarButtonItem?.tintColor = UIColor(red: 203.0/255, green: 69.0/255, blue: 168.0/255, alpha: 1.0)
//        return navigationItem
//    }
    
    
    @objc private func clearImageCache() {
        IGCache.shared.removeAllObjects()
        IGStories.removeAllVideoFilesFromCache()
        presentAlert(title: "Images & Videos are deleted from cache", message: "")
        
    }
    
    
    private func setupView() {
        
        view.backgroundColor = .white
        view.addSubview(storiesCollectionView)
        view.addSubview(feedTableView)
        
        storiesCollectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalTo(feedTableView.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(100)
        }
        
        feedTableView.snp.makeConstraints { (make) in
            make.top.equalTo(storiesCollectionView.safeAreaLayoutGuide.snp.bottom)
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
        return friendViewModel.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friendViewModel.friends[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let friend = friendViewModel.friends[indexPath.row]
            let friendVC = FriendViewController(nickName: friend.nickName, avatarImage: (friend.avatarImage ?? defaultImage)!, name: friend.name, surname: friend.surname, job: friend.job, gender: friend.gender, publicationResult: friend.publicationResult, subscriptionResult: friend.subscriptionResult, subscriberResult: friend.subscriberResult, posts: friend.posts, photos: friend.photos, albums: friend.albums)
            navigationController?.pushViewController(friendVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 630
    }
}


extension FeedViewController: UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesViewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.addStory.rawValue, for: indexPath) as? IGAddStoryCell else { fatalError() }
            cell.userDetails = ("Моя история","avatar")
            return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.listStory.rawValue,for: indexPath) as? IGStoryListCell else { fatalError() }
            let story = storiesViewModel.cellForItemAt(indexPath: indexPath)
            cell.story = story
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            isDeleteSnapEnabled = true
            if(isDeleteSnapEnabled) {
                DispatchQueue.main.async {
                    if let stories = self.storiesViewModel.getStories(), let stories_copy = try? stories.copy().myStory, stories_copy.count > 0 && stories_copy[0].snaps.count > 0 {
//                        IGStoryPreviewController.init(stories: stories_copy, handPickedStoryIndex: indexPath.row, handPickedSnapIndex: 0)
                        let storyPreviewScene = IGStoryPreviewController(stories: stories_copy, handPickedStoryIndex: indexPath.row, handPickedSnapIndex: 0)
                        self.present(storyPreviewScene, animated: true, completion: nil)
                    } else {
                        self.presentAlert(title: "Перенаправление к экрану добавления истории", message: "")
                    }
                }
            } else {
                presentAlert(title: "Попробуйте реализовать свой собственный функционал для 'Вашей истории' ", message: "")
            }
        }else {
            isDeleteSnapEnabled = false
            DispatchQueue.main.async {
                if let stories = self.storiesViewModel.getStories(), let stories_copy = try? stories.copy().otherStories {
                    let storyPreviewScene = IGStoryPreviewController(stories: stories_copy, handPickedStoryIndex:  indexPath.row-1, handPickedSnapIndex: 0)
                    self.present(storyPreviewScene, animated: true, completion: nil)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.row == 0 ? CGSize(width: 100, height: 100) : CGSize(width: 80, height: 100)
    }
}
