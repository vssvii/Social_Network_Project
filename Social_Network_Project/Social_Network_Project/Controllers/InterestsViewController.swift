//
//  InterestsViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 01.03.2023.
//

import UIKit

class InterestsViewController: UIViewController {
    
    
    private lazy var interestsLabel: UILabel = {
        let interestsLabel = UILabel()
        interestsLabel.text = "Ваши интересы:"
        interestsLabel.font = .boldSystemFont(ofSize: 15)
        return interestsLabel
    }()
    
    private lazy var interestsAnswerLabel: UILabel = {
        let interestsAnswerLabel = UILabel()
        interestsAnswerLabel.text = "Спорт, Книги"
        interestsAnswerLabel.font = .systemFont(ofSize: 14)
        return interestsAnswerLabel
    }()
    
    private lazy var interestsTextField: UITextField = {
        let interestsTextField = UITextField()
        interestsTextField.placeholder = "tell_us_about_your_interests".localized
        interestsTextField.backgroundColor = UIColor(hex: "#F5F3EE")
        interestsTextField.layer.cornerRadius = 10
        return interestsTextField
    }()
    
    private lazy var interestsButton: UIButton = {
        let interestsButton = UIButton()
        interestsButton.layer.cornerRadius = 10
        interestsButton.setTitle("change".localized, for: .normal)
        interestsButton.backgroundColor = Tint.orange
        interestsButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return interestsButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setNavigationBar()
    }
    
    private func setupView() {
        
        title = "interests".localized
        
        view.backgroundColor = .white
        
        view.addSubview(interestsLabel)
        view.addSubview(interestsAnswerLabel)
        view.addSubview(interestsTextField)
        view.addSubview(interestsButton)
        
        interestsLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        interestsAnswerLabel.snp.makeConstraints { make in
            make.top.equalTo(interestsLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        interestsTextField.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(interestsAnswerLabel.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
        interestsButton.snp.makeConstraints { make in
            make.top.equalTo(interestsTextField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        
    }
    
    private func setNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
    }
    
    @objc func goBack() {
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveData() {
        if interestsTextField.text != nil {
            interestsAnswerLabel.text = interestsTextField.text
        } else {
            presentAlert(title: "enter_all_fields".localized, message: "")
        }
    }
}
