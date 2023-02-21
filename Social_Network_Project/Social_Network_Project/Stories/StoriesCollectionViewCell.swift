//
//  StoriesCollectionViewCell.swift
//  Social_Network_Project
//
//  Created by Developer on 18.02.2023.
//

import UIKit
import SnapKit

class StoriesCollectionViewCell: UICollectionViewCell {
    
    
    var storiesImageView: UIImageView = {
        let storiesImageView = UIImageView()
        storiesImageView.layer.borderColor = UIColor.white.cgColor
        storiesImageView.clipsToBounds = true
        storiesImageView.layer.borderWidth = 1
        storiesImageView.layer.borderColor = UIColor.init(hex: "FF9E45").cgColor
        storiesImageView.layer.cornerRadius = 25
        return storiesImageView
    }()
    
    lazy var nickLabel: UILabel = {
        let nickLabel = UILabel()
        return nickLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        contentView.backgroundColor = .white
        
        
        contentView.addSubview(storiesImageView)
        contentView.addSubview(nickLabel)
        
        storiesImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        nickLabel.snp.makeConstraints { (make) in
            make.top.equalTo(storiesImageView.snp.bottom).offset(6)
            make.centerX.equalTo(storiesImageView.snp.centerX)
        }
    }
}


