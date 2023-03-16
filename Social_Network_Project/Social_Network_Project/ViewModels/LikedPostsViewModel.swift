//
//  LikedPostsViewModel.swift
//  Social_Network_Project
//
//  Created by Developer on 09.03.2023.
//

import UIKit
import CoreData

class LikedPostsViewModel: NSObject {
    
    var posts = [PostData]()
    
    func reloadPosts() {
        let request = PostData.fetchRequest()
        
        let posts = (try? CoreDataManager.shared.persistentContainer.viewContext.fetch(request)) ?? []
        self.posts = posts
        
    }
    
    func addNewPost(surname: String, name: String, description: String) {
        let post = PostData(context: CoreDataManager.shared.persistentContainer.viewContext)
        post.name = name
        post.surname = surname
        post.descript = description
        CoreDataManager.shared.saveContext()
        reloadPosts()
        }
    
    func deletePosts(post: PostData) {
        CoreDataManager.shared.persistentContainer.viewContext.delete(post)
        CoreDataManager.shared.saveContext()
        reloadPosts()
    }
    
    func deleteAll() {
        
        guard let url = CoreDataManager.shared.persistentContainer.persistentStoreDescriptions.first?.url else { return }
        
        let persistentStoreCoordinator = CoreDataManager.shared.persistentContainer.persistentStoreCoordinator

             do {
                 try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
                 
                 try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
                 
             } catch {
                 print("Attempted to clear persistent store: " + error.localizedDescription)
             }
    }
    
    

}
