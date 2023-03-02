//
//  ContactsViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 01.03.2023.
//

import UIKit

class ContactsViewController: UIViewController {
    
    
    let contacts: [String] = ["Чарльз", "Расул", "Алишер", "Александр", "Светлана", "Динара", "Гульнур", "Адилет", "Томирис", "Ришад"]
    
    
    private enum CellReuseIdentifiers: String {
        case contacts
    }
    

    lazy var contactsTableView: UITableView = {
        let contactsTableView = UITableView(frame: .zero, style: .grouped)
        contactsTableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: CellReuseIdentifiers.contacts.rawValue)
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        return contactsTableView
    }()

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
        
        title = "contacts".localized
        
        view.backgroundColor = .white
        
        view.addSubview(contactsTableView)
        
        contactsTableView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}


extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = contacts[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseIdentifiers.contacts.rawValue) as! ContactsTableViewCell
        cell.contactLabel.text = contact
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

