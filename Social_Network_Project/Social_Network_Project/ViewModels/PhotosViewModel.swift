//
//  PhotosViewModel.swift
//  Social_Network_Project
//
//  Created by Developer on 07.02.2023.
//

import UIKit

class PhotosViewModel: NSObject {
    
    // MARK: Data of photos and albums
    
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
