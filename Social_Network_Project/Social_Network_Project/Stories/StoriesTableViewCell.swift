//
//  StoriesTableViewCell.swift
//  Social_Network_Project
//
//  Created by Developer on 19.02.2023.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {
    
    let viewModel = StoriesViewModel()
    
    
    private enum CellReuseIdentifiers: String {
        case stories
    }
    
    lazy var storiesCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        viewLayout.minimumLineSpacing = 5
        let albumCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayout)
        albumCollectionView.register(StoriesCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifiers.stories.rawValue)
        albumCollectionView.showsHorizontalScrollIndicator = false
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        return albumCollectionView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    private func setupView() {
        
        contentView.backgroundColor = .white
        
        
        contentView.addSubview(storiesCollectionView)
        
        
        storiesCollectionView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
}


extension StoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.stories.count
    }
        
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let story = viewModel.stories[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.stories.rawValue, for: indexPath) as! StoriesCollectionViewCell
        cell.nickLabel.text = story.nick
        cell.storiesImageView.image = story.image
        return cell
    }
        
        
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 80)
    }
        
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                        return 30
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
        
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                        print(indexPath.row)
    }
 
}
