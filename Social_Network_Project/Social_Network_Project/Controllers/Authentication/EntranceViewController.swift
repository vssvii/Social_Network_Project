//
//  EntranceViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 16.02.2023.
//

import UIKit
import SnapKit

class EntranceViewController: UIViewController {
    
    private lazy var entranceImageView: UIImageView = {
        let entranceImageView = UIImageView()
        entranceImageView.image = UIImage(named: "logo")
        return entranceImageView
    }()
    
    private lazy var registrationButton: UIButton = {
        let registrationButton = UIButton()
        registrationButton.setTitle("ЗАРЕГЕСТРИРОВАТЬСЯ", for: .normal)
        registrationButton.backgroundColor = UIColor(hex: "#2B3940")
        registrationButton.layer.cornerRadius = 10
        registrationButton.addTarget(self, action: #selector(registerVCAction), for: .touchUpInside)
        return registrationButton
    }()
    
    @objc func registerVCAction() {
        let registrationVC = RegistrationViewController()
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    private lazy var signInLabel: UILabel = {
        let signInLabel = UILabel()
        signInLabel.text = "Уже есть аккаунт"
        signInLabel.font = .systemFont(ofSize: 14)
        return signInLabel
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(entranceImageView)
        view.addSubview(registrationButton)
        view.addSubview(signInLabel)
        
        entranceImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.width.height.equalTo(350)
            make.centerX.equalToSuperview()
        }
        
        registrationButton.snp.makeConstraints { (make) in
            make.top.equalTo(entranceImageView.snp.bottom).offset(80)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
        
        signInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(registrationButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
    }
}
