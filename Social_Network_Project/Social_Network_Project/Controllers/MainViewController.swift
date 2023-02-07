//
//  MainViewController.swift
//  Social_Network_Project
//
//  Created by Developer on 03.02.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        
        createSegmentedControl()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
    }
    
    private func createSegmentedControl() {
        let viewControllers = ["Новости", "Для вас"]
        let segmentedControl = UISegmentedControl(items: viewControllers)
        segmentedControl.addTarget(self, action: #selector(suitDidChange(_:)), for: .valueChanged)
        view.addSubview(segmentedControl)
        
        segmentedControl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func suitDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let feedVC = FeedViewController()
            navigationController?.pushViewController(feedVC, animated: true)
        case 1:
            let personalVC = PersonalViewController()
            navigationController?.pushViewController(personalVC, animated: true)
        default:
            let mainVC = MainViewController()
            navigationController?.pushViewController(mainVC, animated: true)
        }
    }
}
