//
//  LikedPostsViewModel.swift
//  Social_Network_Project
//
//  Created by Developer on 09.03.2023.
//

//import UIKit
//import CoreData
//
//class LikedPostsViewModel: NSObject {
//    
//    
//    var posts: [PostData]?
//    
//    
//    func saveContext () {
//    let context = persistentContainer.viewContext
//        
//    if context.hasChanges {
//        do {
//            try context.save()
//        } catch {
//            let nserror = error as NSError
//            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//        }
//      }
//    }
//    
//    func reloadPosts() {
//        let request = PostData.fetchRequest()
//        
//        let posts = (try? persistentContainer.viewContext.fetch(request)) ?? []
//        self.posts = posts
//        
//    }
//    
//    func addNewPost(surname: String, name: String, description: String) {
//        let post = PostData(context: persistentContainer.viewContext)
//        post.name = name
//        post.surname = surname
//        post.descript = description
//        saveContext()
//        reloadPosts()
//        }
//    
//    func deletePosts(post: PostData) {
//        persistentContainer.viewContext.delete(post)
//        saveContext()
//        reloadPosts()
//    }
//    
//    func deleteAll() {
//        
//        guard let url = persistentContainer.persistentStoreDescriptions.first?.url else { return }
//        
//        let persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
//
//             do {
//                 try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
//                 
//                 try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
//                 
//             } catch {
//                 print("Attempted to clear persistent store: " + error.localizedDescription)
//             }
//    }
//    
//    
//
//}
