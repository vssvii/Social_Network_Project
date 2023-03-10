//
//  Result.swift
//  InstagramStories
//
//  Created by Developer on 21.02.2023
//

import Foundation

public enum IGResult<V, E> {
    case success(V)
    case failure(E)
}
