//
//  ProfileViewModel.swift
//  Social_Network_Project
//
//  Created by Developer on 07.02.2023.
//

import UIKit

class ProfileViewModel: NSObject {
    
    var posts: [Post] = [Post(date: Date(timeIntervalSince1970: 1674182519), description: "В итоге исследователи выделили три главные черты, характеризующие личность слона: внимательность (насколько хорошо животное взаимодействует с окружающей средой), социальность (как животное взаимодействует с сородичами и людьми) и агрессивность (как часто особь проявляет агрессивное поведение в отношении сородичей и людей).", image: UIImage(named: "elephant"), likes: 180),
                         Post(date: Date(timeIntervalSince1970: 1674268919), description: "Apple выпустила первый SwiftUI в 2019 году, предлагая тем самым новый подход создания приложений в декларативном стиле. SwiftUI 4.0, представленный этим летом на WWDC 2022 вместе с iOS 16 и macOS 13 включает в себя много нововведений для более качественных и универсальных приложений под разные платформы Apple с меньшим количеством кода.", image: UIImage(named: "swiftUI"), likes: 300)]
    
    var albums: [Album] = [Album(photos: [Photo(image: UIImage(named: "11")),
                                         Photo(image: UIImage(named: "12")),
                                          Photo(image: UIImage(named: "13")),
                                          Photo(image: UIImage(named: "14")),
                                         Photo(image: UIImage(named: "15"))
                                        ], image: UIImage(named: "14"), name: "Машины"),
                          Album(photos: [Photo(image: UIImage(named: "16")),
                                       Photo(image: UIImage(named: "17")),
                                        Photo(image: UIImage(named: "18")),
                                        Photo(image: UIImage(named: "19")),
                                       Photo(image: UIImage(named: "20"))
                                        ], image: UIImage(named: "18"), name: "Люди")]
    
    
    
    var photos: [Photo] = [Photo(image: UIImage(named: "1")),
                           Photo(image: UIImage(named: "2")),
                           Photo(image: UIImage(named: "3")),
                           Photo(image: UIImage(named: "4")),
                           Photo(image: UIImage(named: "5")),
                           Photo(image: UIImage(named: "6")),
                           Photo(image: UIImage(named: "7")),
                           Photo(image: UIImage(named: "8")),
                           Photo(image: UIImage(named: "9")),
                           Photo(image: UIImage(named: "10"))]
    
}
