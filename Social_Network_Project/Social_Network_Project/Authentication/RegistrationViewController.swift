//
//  RegistrationViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 16.02.2023.
//

import UIKit
import SnapKit

final class RegistrationViewController: UIViewController {
    
    
    // MARK: Outlets
    
    
    var phoneNumber: ((String?) -> Void)?
    
    private lazy var registrationLabel: UILabel = {
        let registrationLabel = UILabel()
        registrationLabel.text = "register".localized
        registrationLabel.textColor = Tint.oxfordBlue
        registrationLabel.font = .boldSystemFont(ofSize: 18)
        registrationLabel.numberOfLines = 0
        return registrationLabel
    }()
    
    private lazy var writeNumberLabel: UILabel = {
        let writeNumberLabel = UILabel()
        writeNumberLabel.text = "write_number".localized
        writeNumberLabel.font = .systemFont(ofSize: 16)
        writeNumberLabel.textColor = UIColor(hex: "#D9D9D9")
        writeNumberLabel.numberOfLines = 0
        return writeNumberLabel
    }()
    
    private lazy var numberDescriptionLabel: UILabel = {
        let numberDescriptionLabel = UILabel()
        numberDescriptionLabel.text = "your_number_will_be_used".localized
        numberDescriptionLabel.textColor = Tint.textGray
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
//        writeNumberTextField.placeholder = "+7(___) ___ __ __"
        writeNumberTextField.layer.cornerRadius = 10
        writeNumberTextField.delegate = self
        return writeNumberTextField
    }()
    
    private lazy var goOnButton: UIButton = {
        let goOnButton = UIButton()
        goOnButton.setTitle("go_on".localized, for: .normal)
        goOnButton.backgroundColor = Tint.oxfordBlue
        goOnButton.layer.cornerRadius = 10
        goOnButton.addTarget(self, action: #selector(registerConfirmationVC), for: .touchUpInside)
        return goOnButton
    }()
    
    @objc func registerConfirmationVC() -> Bool {
        
        if let number = writeNumberTextField.text, !number.isEmpty {
            AuthManager.shared.startAuth(phoneNumber: number) { [weak self] success in
                guard success else { return }
                DispatchQueue.main.async {
                    let registerConfirmationVC = RegisterConfirmationViewController(phoneNumber: number)
                    self?.navigationController?.pushViewController(registerConfirmationVC, animated: true)
                }
            }
        }
        return true
    }
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "accept_the_user_agreement".localized
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.textColor = Tint.textGray
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    // MARK: Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setNavigationBar()
    }
    
    
    private func setNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goToEntrancePageAction))
        navigationItem.leftBarButtonItem?.tintColor = Tint.greenBlack
    }
    
    @objc func goToEntrancePageAction() {
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
    
    // MARK: SetupConstraints
    
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


extension RegistrationViewController: UITextFieldDelegate {
    
    
    // MARK: Format setup +X (XXX) XXX-XXXX of number


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+X (XXX) XXX-XXXX", phone: newString)
        return false
    }
}
