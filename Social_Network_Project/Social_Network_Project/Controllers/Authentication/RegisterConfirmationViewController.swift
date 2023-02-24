//
//  RegisterConfirmationViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 16.02.2023.
//

import UIKit
import SnapKit
import FirebaseAuth
import Firebase

class RegisterConfirmationViewController: UIViewController {
    
    private var phoneNumber: String = ""
    
    
    private lazy var confirmationLabel: UILabel = {
        let confirmationLabel = UILabel()
        confirmationLabel.text = "Подтверждение регистрации"
        confirmationLabel.textColor = UIColor(hex: "#F69707")
        confirmationLabel.font = .boldSystemFont(ofSize: 18)
        return confirmationLabel
    }()
    
    private lazy var codeDescriptionLabel: UILabel = {
        let codeDescriptionLabel = UILabel()
        codeDescriptionLabel.text = "Мы отправили SMS с кодом на номер \(phoneNumber)"
        codeDescriptionLabel.font = .systemFont(ofSize: 14)
        codeDescriptionLabel.textAlignment = .center
        codeDescriptionLabel.numberOfLines = 0
        return codeDescriptionLabel
    }()
    
    private lazy var smsDescriptionLabel: UILabel = {
        let smsDescriptionLabel = UILabel()
        smsDescriptionLabel.text = "Введите код из SMS"
        smsDescriptionLabel.font = .systemFont(ofSize: 12)
        smsDescriptionLabel.textColor = UIColor(hex: "#7E8183")
        return smsDescriptionLabel
    }()
    
    private lazy var codeTextField: UITextField = {
        let codeTextField = UITextField()
        codeTextField.backgroundColor = .white
        codeTextField.textColor = .black
        codeTextField.font = .boldSystemFont(ofSize: 15)
        codeTextField.layer.borderWidth = 1
        codeTextField.layer.borderColor = UIColor.black.cgColor
        codeTextField.layer.cornerRadius = 10
        return codeTextField
    }()
    
    private lazy var registrationButton: UIButton = {
        let registrationButton = UIButton()
        registrationButton.setTitle("ЗАРЕГИСТРИРОВАТЬСЯ", for: .normal)
        registrationButton.backgroundColor = UIColor(hex: "#263238")
        registrationButton.layer.cornerRadius = 10
        registrationButton.addTarget(self, action: #selector(finishRegistrationAction), for: .touchUpInside)
        return registrationButton
    }()
    
    @objc func finishRegistrationAction() {
        
        if let text = codeTextField.text, !text.isEmpty {
            let code = text
            AuthManager.shared.verifyCode(smsCode: code) { success in
                guard success else {
                    self.presentAlert(title: "Неверный код!", message: "")
                    return
                }
                DispatchQueue.main.async {
                    let mainViewItem = UITabBarItem()
                    mainViewItem.title = "Главная"
                    mainViewItem.image = UIImage(systemName: "house.fill")
                    let mainVC = MainViewController()
                    mainVC.tabBarItem = mainViewItem
                    let mainNVC = UINavigationController(rootViewController: mainVC)
                    
                    let profileItem = UITabBarItem()
                    profileItem.title = "Профиль"
                    profileItem.image = UIImage(systemName: "person.fill")
                    let profileVC = ProfileViewController(nickName: "vssvii", name: "Ибрагим", surname: "Асайбулдаев", job: "iOS разработчик", gender: "мужской", birth: "17 декабря 1995", city: "Астана")
                    profileVC.title = "Профиль"
                    profileVC.tabBarItem = profileItem
                    let profileNVC = UINavigationController(rootViewController: profileVC)
                    
                    let savedPostsItem = UITabBarItem()
                    savedPostsItem.title = "Сохраненные"
                    savedPostsItem.image = UIImage(systemName: "heart.fill")
                    let likedPostsVC = LikedPostsViewController()
                    likedPostsVC.title = "Сохраненные"
                    likedPostsVC.tabBarItem = savedPostsItem
                    let likedPostsNVC = UINavigationController(rootViewController: likedPostsVC)
                    
                    let entranceItem = UIBarButtonItem()
                    let entranceVC = EntranceViewController()
                    let entranceNVC = UINavigationController(rootViewController: entranceVC)
                    
                    let tabBarController = UITabBarController()
                    tabBarController.viewControllers = [mainNVC, profileNVC, likedPostsNVC]
                    tabBarController.selectedIndex = 1
                    tabBarController.tabBar.tintColor = Tint.orange
                    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                    appDelegate.window?.rootViewController = tabBarController
                    appDelegate.window?.makeKeyAndVisible()
//                    let profileViewController = ProfileViewController()
//                    self.navigationController?.pushViewController(profileViewController, animated: true)
                }
            }
        }
    }
    
    private lazy var checkImageView: UIImageView = {
        let checkImageView = UIImageView()
        checkImageView.image = UIImage(named: "logoCheck")
        return checkImageView
    }()
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
//        self.codeDescriptionLabel.text = "Мы отправили SMS с кодом на номер +\(phoneNumber)"
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goToRegistrationPageAction))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: "#1E201D")
    }
    
    @objc func goToRegistrationPageAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(confirmationLabel)
        view.addSubview(codeDescriptionLabel)
        view.addSubview(smsDescriptionLabel)
        view.addSubview(codeTextField)
        view.addSubview(registrationButton)
        view.addSubview(checkImageView)
        
        
        confirmationLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        codeDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(confirmationLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(265)
        }
        
        smsDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(codeDescriptionLabel.snp.bottom).offset(120)
            make.centerX.equalToSuperview()
        }
        
        codeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(smsDescriptionLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        registrationButton.snp.makeConstraints { (make) in
            make.top.equalTo(codeTextField.snp.bottom).offset(90)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
        
        checkImageView.snp.makeConstraints { (make) in
            make.top.equalTo(registrationButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(85)
            make.height.equalTo(100)
        }
    }
}
