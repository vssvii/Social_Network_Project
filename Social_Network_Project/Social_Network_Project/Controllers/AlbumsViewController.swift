//
//  AlbumsViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 08.02.2023.
//

import UIKit
import SnapKit

// MARK: View of albums
final class AlbumsViewController: UIViewController {
    
    var albums: [Album]
    
    private enum CellReuseIdentifiers: String {
        case albums
    }
    
    
    lazy var albumsCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        let albumsCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: viewLayout)
        albumsCollectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: CellReuseIdentifiers.albums.rawValue)
        albumsCollectionView.showsHorizontalScrollIndicator = false
        albumsCollectionView.delegate = self
        albumsCollectionView.dataSource = self
        return albumsCollectionView
    }()
    
    init(albums: [Album]) {
        self.albums = albums
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
        navigationItem.leftBarButtonItem?.tintColor = Tint.orange
    }

    @objc func goBack() {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setupView() {
        
        title = "albums".localized
        view.backgroundColor = .white
        
        view.addSubview(albumsCollectionView)
        
        albumsCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
}


extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
        
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let album = albums[indexPath.item]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifiers.albums.rawValue, for: indexPath) as! AlbumsCollectionViewCell
        cell.nameLabel.text = album.name
        cell.albumImageView.image = album.image
        let photosTapRecognizer = TapGestureRecognizer(block: { [self] in
            let photosVC = AlbumPhotosViewController(photos: album.photos)
            self.navigationController?.pushViewController(photosVC, animated: true)
        })
        photosTapRecognizer.numberOfTapsRequired = 1
        cell.albumImageView.isUserInteractionEnabled = true
        cell.albumImageView.addGestureRecognizer(photosTapRecognizer)
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
