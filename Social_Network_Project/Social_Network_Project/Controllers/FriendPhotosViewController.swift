//
//  FriendPhotosViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 24.02.2023.
//

import UIKit
import Foundation
import SnapKit



class FriendPhotosViewController: UIViewController, UINavigationBarDelegate {
    
    let viewModel = FriendViewModel()
    
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
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
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

extension FriendPhotosViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        if albums == nil {
            tableView.isHidden = true
                    }
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
            return 600
        }
    }
}


extension FriendPhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        let photo = Photo(image: image)
        
        photos.append(photo)
        
        albumAndPhotosTableView.reloadData()
        
        
        dismiss(animated: true)
        
        
        
        
    }
}
