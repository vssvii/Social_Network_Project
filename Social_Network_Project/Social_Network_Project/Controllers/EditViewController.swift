//
//  EditViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 15.02.2023.
//

import UIKit
import SnapKit

class EditViewController: UIViewController {
    
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Имя"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return nameLabel
    }()
    
    private lazy var nameTextField: UITextField = {
        let nameTextField = UITextField()
        nameTextField.placeholder = " имя"
        nameTextField.backgroundColor = UIColor(hex: "#F5F3EE")
        return nameTextField
    }()
    
    private lazy var surnameLabel: UILabel = {
        let surnameLabel = UILabel()
        surnameLabel.text = "Фамилия"
        surnameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return surnameLabel
    }()
    
    private lazy var surnameTextField: UITextField = {
        let surnameTextField = UITextField()
        surnameTextField.placeholder = " фамилия"
        surnameTextField.backgroundColor = UIColor(hex: "#F5F3EE")
        return surnameTextField
    }()
    
    private lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.text = "Пол"
        return genderLabel
    }()
    
    private lazy var circleMaleView: UIView = {
        let circleMaleView = UIView()
        circleMaleView.backgroundColor = UIColor(patternImage: UIImage(systemName: "circle")!)
        return circleMaleView
    }()
    
    private lazy var maleLabel: UILabel = {
        let maleLabel = UILabel()
        maleLabel.text = "Мужской"
        return maleLabel
    }()
    
    private lazy var circleFemaleView: UIView = {
        let circleFemaleView = UIView()
        circleFemaleView.backgroundColor = UIColor(patternImage: UIImage(systemName: "circle")!)
        return circleFemaleView
    }()
    
    private lazy var femaleLabel: UILabel = {
        let femaleLabel = UILabel()
        femaleLabel.text = "Женский"
        return femaleLabel
    }()
    
    private lazy var birthLabel: UILabel = {
        let birthLabel = UILabel()
        birthLabel.text = "Дата рождения"
        birthLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return birthLabel
    }()
    
    private lazy var birthTextField: UITextField = {
        let birthTextField = UITextField()
        birthTextField.placeholder = " день.месяц.год"
        birthTextField.backgroundColor = UIColor(hex: "#F5F3EE")
        return birthTextField
    }()
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "Родной город"
        cityLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return cityLabel
    }()
    
    private lazy var cityTextField: UITextField = {
        let cityTextField = UITextField()
        cityTextField.placeholder = " Напишите название"
        cityTextField.backgroundColor = UIColor(hex: "#F5F3EE")
        return cityTextField
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupNavigationBar()

        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
    }
    
    @objc func saveData() {
        
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        title = "Основная информация"
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(surnameLabel)
        view.addSubview(surnameTextField)
        view.addSubview(genderLabel)
        view.addSubview(circleMaleView)
        view.addSubview(maleLabel)
        view.addSubview(circleFemaleView)
        view.addSubview(femaleLabel)
        view.addSubview(birthLabel)
        view.addSubview(birthTextField)
        view.addSubview(cityLabel)
        view.addSubview(cityTextField)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
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
        
        genderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(surnameTextField.snp.bottom).offset(16)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
