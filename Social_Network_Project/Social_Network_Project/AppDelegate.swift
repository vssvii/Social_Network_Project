//
//  AppDelegate.swift
//  Social_Network_Project
//
//  Created by Developer on 03.02.2023.
//

import UIKit
import CoreData
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
        
        
        var window: UIWindow?
    
        var orientationLock = UIInterfaceOrientationMask.all

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            window = UIWindow()
            
            FirebaseApp.configure()
            
            
            _ = UIBarButtonItem()
            let entranceVC = EntranceViewController()
            let entranceNVC = UINavigationController(rootViewController: entranceVC)
            let entranceTBC = UITabBarController()
            entranceTBC.viewControllers = [entranceNVC]
            window?.rootViewController = entranceTBC
            window?.makeKeyAndVisible()
            
            
            return true
    }
}
