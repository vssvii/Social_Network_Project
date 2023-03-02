//
//  SignInViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 17.02.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    
    // MARK: Outlets
    
    private lazy var signInLabel: UILabel = {
        let signInLabel = UILabel()
        signInLabel.text = "welcome_back".localized
        signInLabel.textColor = Tint.textOrange
        signInLabel.font = .boldSystemFont(ofSize: 18)
        return signInLabel
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "enter_your_phone_number_to_log_in_to_the_app".localized
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = Tint.oxfordBlue
        return descriptionLabel
    }()
    
    private lazy var numberTextField: UITextField = {
        let numberTextField = UITextField()
        numberTextField.backgroundColor = .white
        numberTextField.textColor = .black
        numberTextField.font = .boldSystemFont(ofSize: 15)
        numberTextField.layer.borderWidth = 1
        numberTextField.layer.borderColor = UIColor.black.cgColor
        numberTextField.layer.cornerRadius = 10
        numberTextField.delegate = self
        return numberTextField
    }()
    
    private lazy var confirmationButton: UIButton = {
        let confirmationButton = UIButton()
        confirmationButton.setTitle("CONFIRM".localized, for: .normal)
        confirmationButton.backgroundColor = Tint.oxfordBlue
        confirmationButton.layer.cornerRadius = 10
        confirmationButton.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        confirmationButton.isUserInteractionEnabled = true
        return confirmationButton
    }()
    
    @objc func signInAction() {
        let registeredNumber = Auth.auth().currentUser?.phoneNumber ?? ""
        let formattedNumber = format(with: "+X (XXX) XXX-XXXX", phone: registeredNumber)
        if numberTextField.text == formattedNumber {
                let mainViewItem = UITabBarItem()
            mainViewItem.title = "main".localized
                mainViewItem.image = UIImage(systemName: "house.fill")
                let mainVC = MainViewController()
                mainVC.tabBarItem = mainViewItem
                let mainNVC = UINavigationController(rootViewController: mainVC)
                
                let profileItem = UITabBarItem()
                profileItem.title = "profile".localized
                profileItem.image = UIImage(systemName: "person.fill")
            let profileVC = ProfileViewController(nickName: "vssvii", name: "Ибрагим", surname: "Асайбулдаев", job: "iOS разработчик", gender: "мужской", birth: "17 декабря 1995", city: "Астана")
            profileVC.title = "profile".localized
                profileVC.tabBarItem = profileItem
                let profileNVC = UINavigationController(rootViewController: profileVC)
                
                let savedPostsItem = UITabBarItem()
            savedPostsItem.title = "favourite_posts".localized
                savedPostsItem.image = UIImage(systemName: "heart.fill")
                let savedPostsVC = LikedPostsViewController()
                savedPostsVC.title = "favourite_posts".localized
                savedPostsVC.tabBarItem = savedPostsItem
                let savedPostsNVC = UINavigationController(rootViewController: savedPostsVC)
                
            _ = UIBarButtonItem()
                let entranceVC = EntranceViewController()
            _ = UINavigationController(rootViewController: entranceVC)
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [mainNVC, profileNVC, savedPostsNVC]
                tabBarController.selectedIndex = 1
                tabBarController.tabBar.tintColor = Tint.orange
                let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                appDelegate.window?.rootViewController = tabBarController
                appDelegate.window?.makeKeyAndVisible()
        } else {
            presentAlert(title: "the_user_with_this_number_is_not_registered".localized, message: "")
        }
    }
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goToRegistrationPageAction))
        navigationItem.leftBarButtonItem?.tintColor = Tint.greenBlack
    }
    
    @objc func goToRegistrationPageAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    
    // MARK: Setup Constraints
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(signInLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(numberTextField)
        view.addSubview(confirmationButton)
        
        signInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(signInLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        numberTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        confirmationButton.snp.makeConstraints { (make) in
            make.top.equalTo(numberTextField.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
    }
}


extension SignInViewController: UITextFieldDelegate {
    
    // MARK: format +X (XXX) XXX-XXXX of number


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+X (XXX) XXX-XXXX", phone: newString)
        return false
    }
}
