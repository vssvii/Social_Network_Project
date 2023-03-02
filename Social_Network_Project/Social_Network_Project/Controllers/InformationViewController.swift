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
        nickNameLabel.text = "nick".localized
        nickNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nickNameLabel.textColor = Tint.textGray
        return nickNameLabel
    }()
    
    private lazy var nickNameAnswerLabel: UILabel = {
        let nickNameAnswerLabel = UILabel()
        nickNameAnswerLabel.text = nickName
        nickNameAnswerLabel.tintColor = .black
        nickNameAnswerLabel.font = .boldSystemFont(ofSize: 16)
        return nickNameAnswerLabel
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "name".localized
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textColor = Tint.textGray
        return nameLabel
    }()
    
    private lazy var nameAnswerLabel: UILabel = {
        let nameAnswerLabel = UILabel()
        nameAnswerLabel.text = name
        nameAnswerLabel.tintColor = .black
        nameAnswerLabel.font = .boldSystemFont(ofSize: 16)
        return nameAnswerLabel
    }()
    
    private lazy var surnameLabel: UILabel = {
        let surnameLabel = UILabel()
        surnameLabel.text = "surname".localized
        surnameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        surnameLabel.textColor = Tint.textGray
        return surnameLabel
    }()
    
    private lazy var surnameAnswerLabel: UILabel = {
        let surnameAnswerLabel = UILabel()
        surnameAnswerLabel.text = surname
        surnameAnswerLabel.tintColor = .black
        surnameAnswerLabel.font = .boldSystemFont(ofSize: 16)
        return surnameAnswerLabel
    }()
    
    private lazy var jobLabel: UILabel = {
        let jobLabel = UILabel()
        jobLabel.text = "job".localized
        jobLabel.font = UIFont.boldSystemFont(ofSize: 14)
        jobLabel.textColor = Tint.textGray
        return jobLabel
    }()
    
    private lazy var jobAnswerLabel: UILabel = {
        let jobAnswerLabel = UILabel()
        jobAnswerLabel.text = job
        jobAnswerLabel.tintColor = .black
        jobAnswerLabel.font = .boldSystemFont(ofSize: 16)
        return jobAnswerLabel
    }()
    
    private lazy var genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.text = "gender".localized
        genderLabel.textColor = Tint.textGray
        genderLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return genderLabel
    }()
    
    private lazy var genderAnswerLabel: UILabel = {
        let genderAnswerLabel = UILabel()
        genderAnswerLabel.text = gender
        genderAnswerLabel.textColor = .black
        genderAnswerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        return genderAnswerLabel
    }()
    
    private lazy var birthLabel: UILabel = {
        let birthLabel = UILabel()
        birthLabel.text = "date_of_birth".localized
        birthLabel.textColor = Tint.textGray
        birthLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return birthLabel
    }()
    
    private lazy var birthAnswerLabel: UILabel = {
        let birthAnswerLabel = UILabel()
        birthAnswerLabel.textColor = .black
        birthAnswerLabel.text = birth
        birthAnswerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        return birthAnswerLabel
    }()
    
    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "hometown".localized
        cityLabel.textColor = Tint.textGray
        cityLabel.font = UIFont.boldSystemFont(ofSize: 14)
        return cityLabel
    }()
    
    private lazy var cityAnswerLabel: UILabel = {
        let cityAnswerLabel = UILabel()
        cityAnswerLabel.textColor = .black
        cityAnswerLabel.text = city
        cityAnswerLabel.font = UIFont.boldSystemFont(ofSize: 16)
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
        navigationItem.leftBarButtonItem?.tintColor = Tint.orange
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        title = "detailed_information"
        
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
