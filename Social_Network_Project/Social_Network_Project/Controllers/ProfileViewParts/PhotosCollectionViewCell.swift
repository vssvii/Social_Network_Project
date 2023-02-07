//
//  PhotosCollectionViewCell.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 05.06.2022.
//

import UIKit
import SnapKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    
    lazy var photoImageView : UIImageView = {
        let photoImageView = UIImageView()
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.backgroundColor = .black
        photoImageView.layer.cornerRadius = 6
        return photoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        contentView.addSubview(photoImageView)
        
        photoImageView.snp.makeConstraints { (make) in
            make.top.right.left.bottom.equalToSuperview()
        }
        
    }
}
