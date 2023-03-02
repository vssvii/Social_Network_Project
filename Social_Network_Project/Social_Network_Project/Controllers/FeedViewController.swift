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
    
    let coreManager = CoreDataManager.shared
    
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
        let post = friend.posts[indexPath.section]
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.feeds.rawValue) as! PostsTableViewCell
            cell.dateLabel.text = friend.date.toString(dateFormat: "MMM d")
            cell.userImageView.image = friend.avatarImage
        
        // MARK: Recognizer which responsibles for opening Friend's Page
        let imageTapRecognizer = TapGestureRecognizer(block: { [self] in
            let friendVC = FriendViewController(nickName: friend.nickName, avatarImage: (friend.avatarImage ?? defaultImage)!, name: friend.name, surname: friend.surname, job: friend.job, gender: friend.gender, publicationResult: friend.publicationResult, subscriptionResult: friend.subscriptionResult, subscriberResult: friend.subscriberResult, posts: friend.posts, photos: friend.photos, albums: friend.albums, comments: post.comments)
            self.navigationController?.pushViewController(friendVC, animated: true)
        })
        cell.userImageView.isUserInteractionEnabled = true
        imageTapRecognizer.numberOfTapsRequired = 1
        cell.userImageView.addGestureRecognizer(imageTapRecognizer)
            cell.nameLabel.text = friend.name
            cell.surnameLabel.text = friend.surname
            cell.jobLabel.text = friend.job
            cell.postTextLabel.text = friend.text
            cell.postImageVIew.image = friend.image
            cell.likesLabel.text = "\(friend.likes)"
        
        // MARK: Recognizer which responsibles for adding post to coreData in LikedPostsViewController
            let likedtapRecognizer = TapGestureRecognizer(block: { [self] in
                if coreManager.posts.contains( where: { $0.descript == post.description })  {
                presentAlert(title: "", message: "Пост уже был добавлен")
            } else {
                cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .highlighted)
                cell.likeButton.tintColor = .red
                self.coreManager.addNewPost(surname: friend.surname, name: friend.name, description: post.description)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
            }
        })
        likedtapRecognizer.numberOfTapsRequired = 1
            cell.likeButton.isUserInteractionEnabled = true
            cell.likeButton.addGestureRecognizer(likedtapRecognizer)
        let commentTapRecognizer = TapGestureRecognizer(block: { [self] in
            let postVC = PostViewController(userImage: friend.avatarImage ?? UIImage(named: "")!, nickName: friend.nickName, job: friend.job, image: friend.image ?? UIImage(named: "")!, text: post.description, likesCount: post.likes, date: post.date, comments: post.comments)
            self.navigationController?.pushViewController(postVC, animated: true)
        })
        commentTapRecognizer.numberOfTapsRequired = 1
        cell.postImageVIew.isUserInteractionEnabled = true
        cell.postImageVIew.addGestureRecognizer(commentTapRecognizer)
            return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            let friend = friendViewModel.friends[indexPath.row]
//            let friendVC = FriendViewController(nickName: friend.nickName, avatarImage: (friend.avatarImage ?? defaultImage)!, name: friend.name, surname: friend.surname, job: friend.job, gender: friend.gender, publicationResult: friend.publicationResult, subscriptionResult: friend.subscriptionResult, subscriberResult: friend.subscriberResult, posts: friend.posts, photos: friend.photos, albums: friend.albums)
//            navigationController?.pushViewController(friendVC, animated: true)
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 480
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
                        self.presentAlert(title: "redirecting_to_the_history_adding_screen".localized, message: "")
                    }
                }
            } else {
                presentAlert(title: "try_implement_functionality".localized, message: "")
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
