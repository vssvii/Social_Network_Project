//
//  IGCache.swift
//  Social_Network_Project
//
//  Created by Ibragim Assaibuldayev on 21.02.2023
//

import Foundation

fileprivate let ONE_HUNDRED_MEGABYTES = 1024 * 1024 * 100

class IGCache: NSCache<AnyObject, AnyObject> {
    static let shared = IGCache()
    private override init() {
        super.init()
        self.setMaximumLimit()
    }
}

extension IGCache {
    func setMaximumLimit(size: Int = ONE_HUNDRED_MEGABYTES) {
        totalCostLimit = size
    }
}
