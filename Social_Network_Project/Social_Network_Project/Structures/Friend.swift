//
//  Feed.swift
//  Social_Network_Project
//
//  Created by Developer on 09.02.2023.
//

import UIKit

struct Friend {
    
    let date: Date
    let avatarImage: UIImage?
    let nickName: String
    let surname: String
    let name: String
    let job: String
    let gender: String
    let text: String
    let image: UIImage?
    let likes: Int
    let publicationResult: Int
    let subscriptionResult: Int
    let subscriberResult: Int
    let posts: [Post]
    let photos: [Photo]
    let albums: [Album]
    
}
