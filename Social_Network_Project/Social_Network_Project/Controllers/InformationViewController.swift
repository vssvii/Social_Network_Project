//
//  InformationViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 21.02.2023.
//

import UIKit
import SnapKit

class InformationViewController: UIViewController {
    
    var nickName: String?
    var name: String?
    var surname: String?
    var job: String?
    var gender: String?
    var birth: String?
    var city: String?
    
    
    private lazy var nickNameLabel: UILabel = {
        let nickNameLabel = UILabel()
        nickNameLabel.text = "Ник"
        nickNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        nickNameLabel.textColor = UIColor(hex: "#7E8183")
        return nickNameLabel
    }()
    
    private lazy var nickNameAnswerLabel: UILabel = {
        let nickNameAnswerLabel = UILabel()
        nickNameAnswerLabel.text = nickName
        nickNameAnswerLabel.tintColor = .black
        nickNameAnswerLabel.font = .systemFont(ofSize: 14)
        return nickNameAnswerLabel
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Имя"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        nameLabel.textColor = UIColor(hex: "#7E8183")
        return nameLabel
    }()
    
    private lazy var nameAnswerLabel: UILabel = {
        let nameAnswerLabel = UILabel()
        nameAnswerLabel.text = name
        nameAnswerLabel.tintColor = .black
        nameAnswerLabel.font = .systemFont(ofSize: 14)
        return nameAnswerLabel
    }()
    
    private lazy var surnameLabel: UILabel = {
        let surnameLabel = UILabel()
        surnameLabel.text = "Фамилия"
        surnameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        surnameLabel.textColor = UIColor(hex: "#7E8183")
        return surnameLabel
    }()
    
    private lazy var surnameAnswerLabel: UILabel = {
        let surnameAnswerLabel = UILabel()
        surnameAnswerLabel.text = surname
        surnameAnswerLabel.tintColor = .black
        surnameAnswerLabel.font = .systemFont(ofSize: 14)
        return surnameAnswerLabel
    }()
    
    private lazy var jobLabel: UILabel = {
        let jobLabel = UILabel()
        jobLabel.text = "Профессия"
        jobLabel.font = UIFont.boldSystemFont(ofSize: 12)
        jobLabel.textColor = UIColor(hex: "#7E8183")
        return jobLabel
    }()
    
    private lazy var jobAnswerLabel: UILabel = {
        let jobAnswerLabel = UILabel()
        jobAnswerLabel.text = job
        jobAnswerLabel.tintColor = .black
        jobAnswerLabel.font = .systemFont(ofSize: 14)
        return jobAnswerLabel
    }()
    
    private lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.text = "Пол"
        genderLabel.textColor = UIColor(hex: "#7E8183")
        genderLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return genderLabel
    }()
    
    private lazy var genderAnswerLabel: UILabel = {
        let genderAnswerLabel = UILabel()
        genderAnswerLabel.text = gender
        genderAnswerLabel.textColor = .black
        genderAnswerLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return genderAnswerLabel
    }()
    
    private lazy var birthLabel: UILabel = {
        let birthLabel = UILabel()
        birthLabel.text = "Дата рождения"
        birthLabel.textColor = UIColor(hex: "#7E8183")
        birthLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return birthLabel
    }()
    
    private lazy var birthAnswerLabel: UILabel = {
        let birthAnswerLabel = UILabel()
        birthAnswerLabel.textColor = .black
        birthAnswerLabel.text = birth
        birthAnswerLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return birthAnswerLabel
    }()
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "Родной город"
        cityLabel.textColor = UIColor(hex: "#7E8183")
        cityLabel.font = UIFont.boldSystemFont(ofSize: 12)
        return cityLabel
    }()
    
    private lazy var cityAnswerLabel: UILabel = {
        let cityAnswerLabel = UILabel()
        cityAnswerLabel.textColor = .black
        cityAnswerLabel.text = city
        cityAnswerLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return cityAnswerLabel
    }()
    
    init(nickName: String, name: String, surname: String, job: String, gender: String, birth: String, city: String) {
        self.nickName = nickName
        self.name = name
        self.surname = surname
        self.job = job
        self.gender = gender
        self.birth = birth
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupNavigationBar()

        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .done, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: "#FF9E45")
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        title = "Основная информация"
        
        view.addSubview(nickNameLabel)
        view.addSubview(nickNameAnswerLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameAnswerLabel)
        view.addSubview(surnameLabel)
        view.addSubview(surnameAnswerLabel)
        view.addSubview(jobLabel)
        view.addSubview(jobAnswerLabel)
        view.addSubview(genderLabel)
        view.addSubview(genderAnswerLabel)
        view.addSubview(birthLabel)
        view.addSubview(birthAnswerLabel)
        view.addSubview(cityLabel)
        view.addSubview(cityAnswerLabel)
        
        nickNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        nickNameAnswerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)

        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nickNameAnswerLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        nameAnswerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        surnameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameAnswerLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        surnameAnswerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(surnameLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        jobLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(surnameAnswerLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        jobAnswerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        genderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(jobAnswerLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        genderAnswerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(genderLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        birthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(genderAnswerLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        birthAnswerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(birthLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
        
        cityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(birthAnswerLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
        }
        
        cityAnswerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cityLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().offset(16)
        }
    }
}
