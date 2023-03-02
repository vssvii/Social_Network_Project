//
//  CareerViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 01.03.2023.
//

import UIKit

class CareerViewController: UIViewController {
    
    private lazy var positionLabel: UILabel = {
        let positionLabel = UILabel()
        positionLabel.text = "position".localized
        positionLabel.font = .boldSystemFont(ofSize: 15)
        return positionLabel
    }()
    
    private lazy var positionAnswerLabel: UILabel = {
        let positionAnswerLabel = UILabel()
        positionAnswerLabel.text = "iOS разработчик"
        positionAnswerLabel.font = .systemFont(ofSize: 14)
        return positionAnswerLabel
    }()
    
    private lazy var positionTextField: UITextField = {
        let positionTextField = UITextField()
        positionTextField.placeholder = "enter_position".localized
        positionTextField.backgroundColor = UIColor(hex: "#F5F3EE")
        positionTextField.layer.cornerRadius = 10
        return positionTextField
    }()
    
    private lazy var workPlaceLabel: UILabel = {
        let workPlaceLabel = UILabel()
        workPlaceLabel.text = "place_of_work".localized
        workPlaceLabel.font = .boldSystemFont(ofSize: 15)
        return workPlaceLabel
    }()
    
    private lazy var workPlaceAnswerLabel: UILabel = {
        let workPlaceAnswerLabel = UILabel()
        workPlaceAnswerLabel.text = "Нанкинский университет наук и технологий"
        workPlaceAnswerLabel.font = .systemFont(ofSize: 14)
        return workPlaceAnswerLabel
    }()
    
    private lazy var workPlaceTextField: UITextField = {
        let workPlaceTextField = UITextField()
        workPlaceTextField.placeholder = "enter_place_of_work".localized
        workPlaceTextField.backgroundColor = UIColor(hex: "#F5F3EE")
        workPlaceTextField.layer.cornerRadius = 10
        return workPlaceTextField
    }()
    
    private lazy var careerButton: UIButton = {
        let careerButton = UIButton()
        careerButton.layer.cornerRadius = 10
        careerButton.setTitle("change".localized, for: .normal)
        careerButton.backgroundColor = Tint.orange
        careerButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        return careerButton
    }()
    
    @objc func saveData() {
        
        if positionTextField.text != nil && workPlaceTextField.text != nil {
            positionAnswerLabel.text = positionTextField.text
            workPlaceAnswerLabel.text = workPlaceTextField.text
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
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
    }
    
    @objc func goBack() {
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        title = "careers".localized
        
        view.addSubview(positionLabel)
        view.addSubview(positionAnswerLabel)
        view.addSubview(positionTextField)
        view.addSubview(workPlaceLabel)
        view.addSubview(workPlaceAnswerLabel)
        view.addSubview(workPlaceTextField)
        view.addSubview(careerButton)
        
        positionLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        positionAnswerLabel.snp.makeConstraints { make in
            make.top.equalTo(positionLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        positionTextField.snp.makeConstraints { make in
            make.top.equalTo(positionAnswerLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        workPlaceLabel.snp.makeConstraints { make in
            make.top.equalTo(positionTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        workPlaceAnswerLabel.snp.makeConstraints { make in
            make.top.equalTo(workPlaceLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        workPlaceTextField.snp.makeConstraints { make in
            make.top.equalTo(workPlaceAnswerLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        careerButton.snp.makeConstraints { make in
            make.top.equalTo(workPlaceTextField.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
