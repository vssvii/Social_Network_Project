//
//  ProfileSideMenuViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 11.02.2023.
//

import UIKit
import SnapKit
import SideMenu

class ProfileSideMenuViewController: UIViewController {
    
    
    public var menuDelegate: MenuControllerDelegate?
    
    private enum CellReuseIdentifiers: String {
        case options
    }
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Асайбулдаев Ибрагим"
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return fullNameLabel
    }()
    
    private lazy var nameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Ибрагим"
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return fullNameLabel
    }()
    
    private lazy var separatorLineView: UIView = {
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = Tint.textGray
        return separatorLineView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileSideTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.options.rawValue)
        tableView.backgroundColor = Tint.lightGrayishOrange
        return tableView
    }()
    
    private var menuSideOptions = ["bookmarks".localized, "liked".localized, "files".localized,  "archives".localized, "settings".localized]
    private var menuSideImages = ["bookmark", "heart", "square.and.arrow.up", "personalhotspot", "slider.horizontal.3"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    private func setupView() {
        
        view.backgroundColor = Tint.lightGrayishOrange
        
        view.addSubview(fullNameLabel)
        view.addSubview(separatorLineView)
        view.addSubview(tableView)
        
        
        fullNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        separatorLineView.snp.makeConstraints { (make) in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(2)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLineView.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


extension ProfileSideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSideOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.options.rawValue) as! ProfileSideTableViewCell
        let option = menuSideOptions[indexPath.row]
        cell.backgroundColor = Tint.lightGrayishOrange
        cell.iconImageView.image = UIImage(systemName: menuSideImages[indexPath.row])
        cell.menuLabel.text = option
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = menuSideOptions[indexPath.row]
        menuDelegate?.didSelectMenuItem(named: selectedItem)
        
        if selectedItem == "liked".localized {
            let savedPageVC = LikedPostsViewController()
            navigationController?.pushViewController(savedPageVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
