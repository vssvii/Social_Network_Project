//
//  EditViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 13.02.2023.
//

import UIKit
import SnapKit

class EditMenuViewController: UIViewController {
    
    
    private enum CellReuseIdentifiers: String {
        case editOptions
    }
    
    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "profile".localized
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
        separatorLineView.backgroundColor = UIColor(hex: "#7E8183")
        return separatorLineView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileSideTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.editOptions.rawValue)
        tableView.backgroundColor = UIColor(hex: "F5F3EE")
        return tableView
    }()
    
    private var menuSideOptions = ["basic_information".localized, "contacts".localized, "interests".localized,  "education".localized, "careers".localized]
    
//    enum MenuOptions: String {
//        case basicInfo = "Основная информация"
//        case contacts = "Контакты"
//        case interests = "Интересы"
//        case education = "Образование"
//        case settings = "Карьера"
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    private func setupView() {
        
        view.backgroundColor = UIColor(hex: "F5F3EE")
        
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


extension EditMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSideOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.editOptions.rawValue) as! ProfileSideTableViewCell
        let option = menuSideOptions[indexPath.row]
        cell.backgroundColor = UIColor(hex: "F5F3EE")
        cell.menuLabel.text = option
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = menuSideOptions[indexPath.row]
        if option == "detailed_information".localized {
            let editPageVC = EditViewController()
            navigationController?.pushViewController(editPageVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
