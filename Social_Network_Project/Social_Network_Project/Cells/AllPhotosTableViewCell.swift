//
//  AllPhotosTableViewCell.swift
//  Social_Network_Project
//
//  Created by Developer on 08.02.2023.
//

import UIKit
import SnapKit

class AllPhotosTableViewCell: UITableViewCell {
    
    
    // MARK: Outlets
    
    var photos: [Photo]?
    
    private enum CellReuseIdentifiers: String {
        case photos
    }
    
    lazy var photosLabel: UILabel = {
        let photosLabel = UILabel()
        photosLabel.text = "all_photos".localized
        photosLabel.font = UIFont.boldSystemFont(ofSize: 16)
        photosLabel.textColor = .black
        photosLabel.numberOfLines = 1
        return photosLabel
        }()
    
    lazy var photosCountLabel: UILabel = {
        let photosCountLabel = UILabel()
        photosCountLabel.font = UIFont.boldSystemFont(ofSize: 14)
        photosCountLabel.textColor = UIColor(hex: "#7E8183")
        return photosCountLabel
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.minimumLineSpacing = 5
        viewLayout.scrollDirection = .vertical
        let photosCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayout)
        photosCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifiers.photos.rawValue)
        photosCollectionView.showsHorizontalScrollIndicator = false
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        return photosCollectionView
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    // MARK: Setup Constraints
    
    private func setupView() {
        
        
        contentView.addSubview(photosLabel)
        contentView.addSubview(photosCountLabel)
        contentView.addSubview(photosCollectionView)
        
        photosLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(12)
            make.left.equalTo(contentView.snp.left).offset(12)
        }
        
        photosCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(14)
            make.left.equalTo(photosLabel.snp.right).offset(6)
        }
        
        
        photosCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(photosLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
}

// MARK: Extension - Table View

extension AllPhotosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
        }
        
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos?[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.photos.rawValue, for: indexPath) as! PhotosCollectionViewCell
        cell.photoImageView.image = photo?.image
        if let photos = photos {
            photosCountLabel.text = "\(photos.count)"
        }
        return cell
    }
        
        
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 103, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 103, height: 75)
    }
        
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                        print(indexPath.row)
    }
 
}
