//
//  AlbumsCollectionViewCell.swift
//  Social_Network_Project
//
//  Created by Developer on 07.02.2023.
//

import UIKit

class AlbumsCollectionViewCell: UICollectionViewCell {
    
    
    // MARK: Outlets
    
    lazy var albumImageView : UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.backgroundColor = .black
        photoImageView.layer.cornerRadius = 6
        return photoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Constraints
    
    private func setupView() {
        
        contentView.addSubview(albumImageView)
        contentView.addSubview(nameLabel)
        
        albumImageView.snp.makeConstraints { (make) in
            make.top.right.left.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(albumImageView.snp.bottom).offset(8)
            make.centerX.equalTo(albumImageView.snp.centerX)
        }
    }
}
