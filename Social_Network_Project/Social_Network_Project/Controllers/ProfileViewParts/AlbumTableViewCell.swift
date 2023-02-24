//
//  AlbumTableViewCell.swift
//  Social_Network_Project
//
//  Created by Developer on 08.02.2023.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    
    var albums: [Album]?
    
    private enum CellReuseIdentifiers: String {
        case albums
    }
    
    lazy var albumsLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "Альбомы"
        photosLabel.font = UIFont.boldSystemFont(ofSize: 16)
        photosLabel.textColor = .black
        photosLabel.numberOfLines = 1
        return photosLabel
        }()
    
    lazy var albumsCountLabel: UILabel = {
        let albumsCountLabel = UILabel()
        albumsCountLabel.font = UIFont.boldSystemFont(ofSize: 14)
        albumsCountLabel.textColor = UIColor(hex: "#7E8183")
        return albumsCountLabel
    }()
    
    lazy var showAllButton: UIButton = {
        let showAllButton = UIButton()
        showAllButton.setTitle("Показать все", for: .normal)
        showAllButton.setTitleColor(UIColor(hex: "#FF9E45"), for: .normal)
        return showAllButton
    }()
    
    lazy var albumCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        viewLayout.minimumLineSpacing = 5
        let albumCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayout)
        albumCollectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifiers.albums.rawValue)
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
        
        
        contentView.addSubview(albumsLabel)
        contentView.addSubview(albumsCountLabel)
        contentView.addSubview(showAllButton)
        contentView.addSubview(albumCollectionView)
        
        albumsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.left.equalTo(contentView.snp.left).offset(12)
        }
        
        albumsCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(14)
            make.left.equalTo(albumsLabel.snp.right).offset(6)
        }
        
        showAllButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.right.equalTo(contentView.snp.right).offset(-12)
        }
        
        albumCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(albumsLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

extension AlbumTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
        
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = albums?[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.albums.rawValue, for: indexPath) as! AlbumsCollectionViewCell
        cell.nameLabel.text = album?.name
        cell.albumImageView.image = album?.image
        if let albums = albums {
            albumsCountLabel.text = "\(albums.count)"
        }
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
