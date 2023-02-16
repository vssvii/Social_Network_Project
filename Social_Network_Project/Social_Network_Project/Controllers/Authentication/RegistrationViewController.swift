//
//  RegistrationViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 16.02.2023.
//

import UIKit
import SnapKit
import FirebaseAuth
import Firebase

class RegistrationViewController: UIViewController {
    
    
    private lazy var registrationLabel: UILabel = {
        let registrationLabel = UILabel()
        registrationLabel.text = "ЗАРЕГИСТРИРОВАТЬСЯ"
        registrationLabel.textColor = UIColor(hex: "#263238")
        registrationLabel.font = .boldSystemFont(ofSize: 18)
        registrationLabel.numberOfLines = 0
        return registrationLabel
    }()
    
    private lazy var writeNumberLabel: UILabel = {
        let writeNumberLabel = UILabel()
        writeNumberLabel.text = "Введите номер"
        writeNumberLabel.font = .systemFont(ofSize: 16)
        writeNumberLabel.textColor = UIColor(hex: "#D9D9D9")
        writeNumberLabel.numberOfLines = 0
        return writeNumberLabel
    }()
    
    private lazy var numberDescriptionLabel: UILabel = {
        let numberDescriptionLabel = UILabel()
        numberDescriptionLabel.text = "Ваш номер будет использоваться для входа в аккаунт"
        numberDescriptionLabel.textColor = UIColor(hex: "#7E8183")
        numberDescriptionLabel.font = .systemFont(ofSize: 12)
        numberDescriptionLabel.numberOfLines = 0
        return numberDescriptionLabel
    }()
    
    private lazy var writeNumberTextField: UITextField = {
        let writeNumberTextField = UITextField()
        writeNumberTextField.backgroundColor = .white
        writeNumberTextField.textColor = .black
        writeNumberTextField.font = .boldSystemFont(ofSize: 15)
        writeNumberTextField.layer.borderWidth = 1
        writeNumberTextField.layer.borderColor = UIColor.black.cgColor
        writeNumberTextField.placeholder = "+7(___) ___ __ __"
//        writeNumberTextField.delegate = self
        return writeNumberTextField
    }()
    
    
    private lazy var goOnButton: UIButton = {
        let goOnButton = UIButton()
        goOnButton.setTitle("ДАЛЕЕ", for: .normal)
        goOnButton.backgroundColor = UIColor(hex: "#263238")
        goOnButton.layer.cornerRadius = 10
        goOnButton.addTarget(self, action: #selector(registerConfirmationVC), for: .touchUpInside)
        return goOnButton
    }()
    
    @objc func registerConfirmationVC() -> Bool {
        
        if let text = writeNumberTextField.text, !text.isEmpty {
            let number = "+7\(text)"
            AuthManager.shared.startAuth(phoneNumber: number) { [weak self] success in
                guard success else { return }
                let registerConfirmationVC = RegisterConfirmationViewController()
                self?.navigationController?.pushViewController(registerConfirmationVC, animated: true)
//                DispatchQueue.main.async {
//                    let registerConfirmationVC = RegisterConfirmationViewController()
//                    self?.navigationController?.pushViewController(registerConfirmationVC, animated: true)
//                }
            }
        }
        return true
    }
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Нажимая кнопку “Далее” Вы принимаете пользовательское Соглашение и политику конфедициальности"
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = UIColor(hex: "7E8183")
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setNavigationBar()
        
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goToEntrancePageAction))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: "#1E201D")
    }
    
    @objc func goToEntrancePageAction() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(registrationLabel)
        view.addSubview(writeNumberLabel)
        view.addSubview(numberDescriptionLabel)
        view.addSubview(writeNumberTextField)
        view.addSubview(goOnButton)
        view.addSubview(descriptionLabel)
        
        registrationLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        
        writeNumberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(registrationLabel.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
        }
        
        numberDescriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(writeNumberLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        writeNumberTextField.snp.makeConstraints { (make) in
            make.top.equalTo(numberDescriptionLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(50)
        }
        
        goOnButton.snp.makeConstraints { (make) in
            make.top.equalTo(writeNumberTextField.snp.bottom).offset(65)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(120)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(goOnButton.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
}


//extension RegistrationViewController: UITextFieldDelegate {
//
//
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let allowedCharacters = CharacterSet.decimalDigits
//        let characterSet = CharacterSet(charactersIn: string)
//        return allowedCharacters.isSuperset(of: characterSet)
//    }
//}
