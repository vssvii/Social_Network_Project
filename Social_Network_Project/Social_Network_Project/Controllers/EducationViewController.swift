//
//  EducationViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 01.03.2023.
//

import UIKit

final class EducationViewController: UIViewController {
    
    
    private lazy var educationLevelLabel: UILabel = {
        let educationLevelLabel = UILabel()
        educationLevelLabel.text = "level_of_education".localized
        educationLevelLabel.font = .boldSystemFont(ofSize: 15)
        return educationLevelLabel
    }()
    
    private lazy var educationLevelAnswerLabel: UILabel = {
        let educationLevelAnswerLabel = UILabel()
        educationLevelAnswerLabel.text = "Высшее образование"
        educationLevelAnswerLabel.font = .systemFont(ofSize: 14)
        return educationLevelAnswerLabel
    }()
    
    private lazy var educationLevelTextField: UITextField = {
        let interestsTextField = UITextField()
        interestsTextField.placeholder = "enter_level_education".localized
        interestsTextField.backgroundColor = Tint.lightGrayishOrange
        interestsTextField.layer.cornerRadius = 10
        return interestsTextField
    }()
    
    private lazy var educationPlaceLabel: UILabel = {
        let educationPlaceLabel = UILabel()
        educationPlaceLabel.text = "place_of_study".localized
        educationPlaceLabel.font = .boldSystemFont(ofSize: 15)
        return educationPlaceLabel
    }()
    
    private lazy var educationPlaceAnswerLabel: UILabel = {
        let interestsAnswerLabel = UILabel()
        interestsAnswerLabel.text = "Нанкинский университет наук и технологий"
        interestsAnswerLabel.font = .systemFont(ofSize: 14)
        return interestsAnswerLabel
    }()
    
    private lazy var educationPlaceTextField: UITextField = {
        let interestsTextField = UITextField()
        interestsTextField.placeholder = "enter_place_of_study".localized
        interestsTextField.backgroundColor = Tint.lightGrayishOrange
        interestsTextField.layer.cornerRadius = 10
        return interestsTextField
    }()
    
    private lazy var educationButton: UIButton = {
        let educationButton = UIButton()
        educationButton.layer.cornerRadius = 10
        educationButton.setTitle("change".localized, for: .normal)
        educationButton.backgroundColor = Tint.orange
        educationButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return educationButton
    }()
    
    @objc func saveData() {
        
        if educationLevelTextField.text != nil && educationPlaceTextField.text != nil {
            educationLevelAnswerLabel.text = educationLevelTextField.text
            educationPlaceAnswerLabel.text = educationPlaceTextField.text
        } else {
            presentAlert(title: "enter_all_fields".localized, message: "")
        }
        
    }

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
        
        view.backgroundColor = .white
        title = "education".localized
        
        view.addSubview(educationLevelLabel)
        view.addSubview(educationLevelAnswerLabel)
        view.addSubview(educationLevelTextField)
        view.addSubview(educationPlaceLabel)
        view.addSubview(educationPlaceAnswerLabel)
        view.addSubview(educationPlaceTextField)
        view.addSubview(educationButton)
        
        educationLevelLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        educationLevelAnswerLabel.snp.makeConstraints { make in
            make.top.equalTo(educationLevelLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        educationLevelTextField.snp.makeConstraints { make in
            make.top.equalTo(educationLevelAnswerLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        educationPlaceLabel.snp.makeConstraints { make in
            make.top.equalTo(educationLevelTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        educationPlaceAnswerLabel.snp.makeConstraints { make in
            make.top.equalTo(educationPlaceLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        educationPlaceTextField.snp.makeConstraints { make in
            make.top.equalTo(educationPlaceAnswerLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        educationButton.snp.makeConstraints { make in
            make.top.equalTo(educationPlaceTextField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
}
