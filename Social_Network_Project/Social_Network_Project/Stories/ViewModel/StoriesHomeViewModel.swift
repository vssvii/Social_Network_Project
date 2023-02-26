//
//  StoriesHomeViewModel.swift
//  Social_Network_Project
//
//  Created by Developer on 26.02.2023.


import UIKit

struct StoriesHomeViewModel {
    
    //MARK: - iVars
    //Keep it Immutable! don't get Dirty :P
    private let stories: IGStories? = {
        do {
            return try IGMockLoader.loadMockFile(named: "stories.json", bundle: .main)
        }catch let e as MockLoaderError {
            debugPrint(e.description)
        }catch{
            debugPrint("could not read Mock json file :(")
        }
        return nil
    }()
    
    //MARK: - Public functions
    public func getStories() -> IGStories? {
        return stories
    }
    public func numberOfItemsInSection(_ section:Int) -> Int {
        if let count = stories?.otherStoriesCount {
            return count + 1
        }
        return 1
    }
    public func cellForItemAt(indexPath:IndexPath) -> IGStory? {
        if indexPath.row == 0 {
            return stories?.myStory[indexPath.row]
        }else {
            return stories?.otherStories[indexPath.row-1]
        }
    }
    
}
