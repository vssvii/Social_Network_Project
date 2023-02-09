//
//  MainViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 03.02.2023.
//

import UIKit
import SnapKit
import LZViewPager


class MainViewController: UIViewController  {
    
    private lazy var mainLabel: UILabel = {
        let mainLabel = UILabel()
        mainLabel.text = "Главная"
        mainLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return mainLabel
    }()
    
    private lazy var viewPager: LZViewPager = {
        let viewPager = LZViewPager()
        return viewPager
    }()
    
    private var subControllers: [UIViewController] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        viewPagerProperties()
        

    }
    
    private func viewPagerProperties() {
        
        viewPager.delegate = self
        viewPager.dataSource = self
        viewPager.hostController = self
        
        let feedVC = FeedViewController()
        let personalVC = PersonalViewController()
        
        feedVC.title = "Новости"
        personalVC.title = "Для вас"
        
        subControllers = [feedVC, personalVC]
        
        viewPager.reload()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        view.addSubview(mainLabel)
        view.addSubview(viewPager)
        
        mainLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().offset(16)
        }
        
        viewPager.snp.makeConstraints { (make) in
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
        
        
    }
}


extension MainViewController: LZViewPagerDelegate, LZViewPagerDataSource {
    
    
    
    func numberOfItems() -> Int {
        subControllers.count
    }
    
    func controller(at index: Int) -> UIViewController {
        subControllers[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        return .orange
    }
        
}


