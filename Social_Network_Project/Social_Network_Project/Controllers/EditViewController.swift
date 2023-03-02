//
//  EditViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 15.02.2023.
//

import UIKit
import SnapKit

class EditViewController: UIViewController {
    
    
    private lazy var nickNameLabel: UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.text = "nick".localized
        nickNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return nickNameLabel
    }()
    
    private lazy var nickNameTextField: UITextField = {
        let nickNameTextField = UITextField()
        nickNameTextField.placeholder = "nick".localized
        nickNameTextField.backgroundColor = Tint.lightGrayishOrange
        return nickNameTextField
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "name".localized
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return nameLabel
    }()
    
    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = "name".localized
        nameTextField.backgroundColor = Tint.lightGrayishOrange
        return nameTextField
    }()
    
    private lazy var surnameLabel: UILabel = {
        let surnameLabel = UILabel()
        surnameLabel.text = "surname".localized
        surnameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return surnameLabel
    }()
    
    private lazy var surnameTextField: UITextField = {
        let surnameTextField = UITextField()
        surnameTextField.placeholder = "surname".localized
        surnameTextField.backgroundColor = Tint.lightGrayishOrange
        return surnameTextField
    }()
    
    private lazy var jobLabel: UILabel = {
        let jobLabel = UILabel()
        jobLabel.text = "job".localized
        jobLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return jobLabel
    }()
    
    private lazy var jobTextField: UITextField = {
        let jobTextField = UITextField()
        jobTextField.placeholder = "job".localized
        jobTextField.backgroundColor = Tint.lightGrayishOrange
        return jobTextField
    }()
    
    private lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.text = "gender".localized
        return genderLabel
    }()
    
    private lazy var circleMaleView: UIView = {
        let circleMaleView = UIView()
        circleMaleView.backgroundColor = UIColor(patternImage: UIImage(systemName: "circle")!)
        circleMaleView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleMaleFillAction))
        circleMaleView.addGestureRecognizer(tapGesture)
        return circleMaleView
    }()
    
    @objc func circleMaleFillAction() {
        circleMaleView.backgroundColor = UIColor(patternImage: UIImage(systemName: "circle.circle")!)
        circleFemaleView.backgroundColor = UIColor(patternImage: UIImage(systemName: "circle")!)
    }
    
    private lazy var maleLabel: UILabel = {
        let maleLabel = UILabel()
        maleLabel.text = "male".localized
        return maleLabel
    }()
    
    private lazy var circleFemaleView: UIView = {
        let circleFemaleView = UIView()
        circleFemaleView.backgroundColor = UIColor(patternImage: UIImage(systemName: "circle")!)
        circleFemaleView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(circleFemaleFillAction))
        circleFemaleView.addGestureRecognizer(tapGesture)
        return circleFemaleView
    }()
    
    @objc func circleFemaleFillAction() {
        circleFemaleView.backgroundColor = UIColor(patternImage: UIImage(systemName: "circle.circle")!)
        circleMaleView.backgroundColor = UIColor(patternImage: UIImage(systemName: "circle")!)
    }
    
    private lazy var femaleLabel: UILabel = {
        let femaleLabel = UILabel()
        femaleLabel.text = "female".localized
        return femaleLabel
    }()
    
    private lazy var birthLabel: UILabel = {
        let birthLabel = UILabel()
        birthLabel.text = "date_of_birth".localized
        birthLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return birthLabel
    }()
    
    private lazy var birthTextField: UITextField = {
        let birthTextField = UITextField()
        birthTextField.placeholder = "day.month.year".localized
        birthTextField.backgroundColor = Tint.lightGrayishOrange
        return birthTextField
    }()
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "hometown".localized
        cityLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return cityLabel
    }()
    
    private lazy var cityTextField: UITextField = {
        let cityTextField = UITextField()
        cityTextField.placeholder = "enter_name".localized
        cityTextField.backgroundColor = Tint.lightGrayishOrange
        return cityTextField
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupNavigationBar()

    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem?.tintColor = Tint.orange
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = Tint.orange
    }
    
    @objc func saveData() {
        let profileVC = ProfileViewController(nickName: nickNameTextField.text ?? "", name: nameTextField.text ?? "", surname: surnameTextField.text ?? "", job: jobTextField.text ?? "", gender: "мужской", birth: birthTextField.text ?? "", city: cityTextField.text ?? "")
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        title = "detailed_information".localized
        
        view.addSubview(nickNameLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(surnameLabel)
        view.addSubview(surnameTextField)
        view.addSubview(jobLabel)
        view.addSubview(jobTextField)
        view.addSubview(genderLabel)
        view.addSubview(circleMaleView)
        view.addSubview(maleLabel)
        view.addSubview(circleFemaleView)
        view.addSubview(femaleLabel)
        view.addSubview(birthLabel)
        view.addSubview(birthTextField)
        view.addSubview(cityLabel)
        view.addSubview(cityTextField)
        
        nickNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        nickNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        surnameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        surnameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(surnameLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        jobLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(surnameTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        jobTextField.snp.makeConstraints { (make) in
            make.top.equalTo(jobLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        genderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        circleMaleView.snp.makeConstraints { (make) in
            make.top.equalTo(genderLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(20)
        }
        
        maleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(genderLabel.snp.bottom).offset(10)
            make.left.equalTo(circleMaleView.snp.right).offset(10)
        }
        
        circleFemaleView.snp.makeConstraints { (make) in
            make.top.equalTo(circleMaleView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(20)
        }
        
        femaleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(circleMaleView.snp.bottom).offset(16)
            make.left.equalTo(circleFemaleView.snp.right).offset(10)
        }
        
        birthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(circleFemaleView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(16)
        }
        
        birthTextField.snp.makeConstraints { (make) in
            make.top.equalTo(birthLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        cityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(birthTextField.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        cityTextField.snp.makeConstraints { (make) in
            make.top.equalTo(cityLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        
    }
}
