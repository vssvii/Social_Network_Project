//
//  FeedViewModel.swift
//  Social_Network_Project
//
//  Created by Developer on 09.02.2023.
//

import UIKit


class FeedViewModel: NSObject {
    
    
    var feeds: [Feed] = [Feed(avatarImage: UIImage(named: "ivan"), authorFullName: "Сергей", job: "музыкант", text: "Собираюсь приехать в Алматы в эти выходные и устроить концерт. Приглашаю всех на концерт по адресу г. Алматы, бар Almaty Nights.", image: UIImage(named: "almaty"), likes: 250),
    Feed(avatarImage: UIImage(named: ""), authorFullName: "Димаш Кудайберген", job: "певец", text: "", image: UIImage(named: ""), likes: 300),
                         Feed(avatarImage: UIImage(named: ""), authorFullName: "Алия Берикова", job: "архитектор", text: "", image: UIImage(named: ""), likes: 568),
                         Feed(avatarImage: UIImage(named: ""), authorFullName: "Саша Евлеева", job: "трэвел блогер", text: "", image: UIImage(named: ""), likes: 760),
                         Feed(avatarImage: UIImage(named: ""), authorFullName: "Аскар ", job: "стэндап комик", text: "", image: UIImage(named: ""), likes: 867),
    Feed(avatarImage: UIImage(named: ""), authorFullName: "Молдир Казыбекова", job: "IT менеджер", text: "", image: UIImage(named: ""), likes: 895),
                         Feed(avatarImage: UIImage(named: ""), authorFullName: "", job: "", text: "", image: UIImage(named: ""), likes: 846)]
    
}
