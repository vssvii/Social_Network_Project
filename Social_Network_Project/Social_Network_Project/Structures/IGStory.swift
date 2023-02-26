//
//  IGStory.swift
//  Social_Network_Project
//
//  Created by Developer on 26.02.2023.
//Multiple commands produce '/Users/Developer/Library/Developer/Xcode/DerivedData/Social_Network_Project-dtsvarnunmvuifdsxdfqbvxyldyv/Build/Intermediates.noindex/Social_Network_Project.build/Debug-iphoneos/Social_Network_Project.build/Objects-normal/arm64/IGStoryPreviewController.stringsdata'


import Foundation

public class IGStory: Codable {
    // Note: To retain lastPlayedSnapIndex value for each story making this type as class
    public var snapsCount: Int {
        return snaps.count
    }
    
    // To hold the json snaps.
    private var _snaps: [IGSnap]
    
    // To carry forwarding non-deleted snaps.
    public var snaps: [IGSnap] {
        return _snaps.filter{!($0.isDeleted)}
    }
    public var internalIdentifier: String
    public var lastUpdated: Int
    public var user: IGUser
    var lastPlayedSnapIndex = 0
    var isCompletelyVisible = false
    var isCancelledAbruptly = false
    
    enum CodingKeys: String, CodingKey {
        //case snapsCount = "snaps_count"
        case _snaps = "snaps"
        case internalIdentifier = "id"
        case lastUpdated = "last_updated"
        case user = "user"
    }
}

extension IGStory: Equatable {
    public static func == (lhs: IGStory, rhs: IGStory) -> Bool {
        return lhs.internalIdentifier == rhs.internalIdentifier
    }
}
