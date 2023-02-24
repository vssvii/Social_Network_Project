//
//  StoriesViewModel.swift
//  Social_Network_Project
//
//  Created by Developer on 19.02.2023.
//

import UIKit

class StoriesViewModel: NSObject {
    
    
    let stories: [Stories] = [Stories(image: UIImage(named: "aliya"), nick: "aliyakaz"),
                              Stories(image: UIImage(named: "dimash"), nick: "dimashkud"),
                              Stories(image:
                                        UIImage(named: "sasha"), nick: "aleksandra"),
    Stories(image: UIImage(named: "chingiz"), nick: "china"),
    Stories(image: UIImage(named: "sergei"), nick: "ivanko")]
}
