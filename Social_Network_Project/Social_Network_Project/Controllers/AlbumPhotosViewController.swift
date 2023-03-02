//
//  AlbumPhotosViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 02.03.2023.
//

import UIKit
import SnapKit

class AlbumPhotosViewController: UIViewController {

    var photos: [Photo]
    
    private enum CellReuseIdentifiers: String {
        case photos
    }
    
    
    lazy var photosCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        let photosCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayout)
        photosCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifiers.photos.rawValue)
        photosCollectionView.showsHorizontalScrollIndicator = false
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        return photosCollectionView
    }()
    
    init(photos: [Photo]) {
        self.photos = photos
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
    }
    
    @objc func goBack() {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setupView() {
        
        title = "photos".localized
        view.backgroundColor = .white
        
        view.addSubview(photosCollectionView)
        
        photosCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
}


extension AlbumPhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
        
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.photos.rawValue, for: indexPath) as! PhotosCollectionViewCell
        cell.photoImageView.image = photo.image
        
        return cell
    }
        
        
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 80)
    }
        
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                        return 5
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
        
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                        print(indexPath.row)
    }
 
}
