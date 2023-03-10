//
//  PhotosViewController.swift
//  Navigation_2
//
//  Created by Ibragim Assaibuldayev on 07.06.2022.
//

import UIKit
import Foundation
import SnapKit



final class PhotosViewController: UIViewController, UINavigationBarDelegate {
    
    // MARK: Variables
    
    let viewModel = PhotosViewModel()
    
    var photos: [Photo]
    
    var albums: [Album]
    
    private enum CellReuseIdentifiers: String {
        case allPhotos
        case albums
    }
    
    private enum LayoutCostant {
        static let spacing: CGFloat = 16.0
        static let itemHeight: CGFloat = 300.0
    }
    
    lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar()
        navBar.backgroundColor = .white
        return navBar
    }()
    
    
    lazy var albumAndPhotosTableView: UITableView = {
        let albumAndPhotosTableView = UITableView(frame: .zero, style: .grouped)
        albumAndPhotosTableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.albums.rawValue)
        albumAndPhotosTableView.register(AllPhotosTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.allPhotos.rawValue)
        albumAndPhotosTableView.delegate = self
        albumAndPhotosTableView.dataSource = self
        return albumAndPhotosTableView
    }()
    
    let navItem = UINavigationItem()
    
    init(photos: [Photo], albums: [Album]) {
        self.photos = photos
        self.albums = albums
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupView()
        setNavigationBar()
        
        
        let navItem = UINavigationItem()
        navItem.title = "photos".localized
        
        
        navBar.setItems([navItem], animated: true)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addPhoto))
        navigationItem.rightBarButtonItem?.tintColor = Tint.orange
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = Tint.orange
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addPhoto() {
        
        let imagePC = UIImagePickerController()
        imagePC.sourceType = .photoLibrary
        imagePC.delegate = self
        imagePC.allowsEditing = true
        present(imagePC, animated: true)
    }
    
    // MARK: Constraints
    
    private func setupView() {
        
        view.addSubview(navBar)
        view.addSubview(albumAndPhotosTableView)
        
        navBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(44)
            make.width.equalTo(view.snp.width)
        }
        
        albumAndPhotosTableView.snp.makeConstraints { (make) in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: Extension - Table View

extension PhotosViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.albums.rawValue) as! AlbumTableViewCell
            cell.albums = albums
            cell.showAllButton.addTarget(self, action: #selector(openAlbumsAction), for: .touchUpInside)
          return cell
        } else {
          let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.allPhotos.rawValue) as! AllPhotosTableViewCell
            cell.photos = photos
              return cell
        }
    }
    
    @objc func openAlbumsAction() {
        let albumsVC = AlbumsViewController(albums: albums)
        navigationController?.pushViewController(albumsVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return 500
        }
    }
}

// MARK: Extension - ImagePicker

extension PhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        var photos = viewModel.photos
        _ = Photo(image: image)
        
        photos.append(Photo(image: image))
        
        dismiss(animated: true)
        
        
    }
}
