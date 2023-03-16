//
//  CoreDataManager.swift
//  Navigation_2
//
//  Created by Developer on 15.11.2022.
//

import UIKit
import CoreData

class CoreDataManager {
    
    // MARK: Data of Liked posts
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        
    let container = NSPersistentContainer(name: "PostData")
        
    print(container.persistentStoreDescriptions.first?.url as Any)
        
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
        
    return container
    }()
    
    
    // MARK: - Core Data Saving support
    func saveContext () {
    let context = persistentContainer.viewContext
        
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }
}
