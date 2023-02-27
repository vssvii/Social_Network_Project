//
//  Result.swift
//  InstagramStories
//
//  Created by Ibragim Assaibuldayev on 20.02.2023.
//

import Foundation

public enum IGResult<V, E> {
    case success(V)
    case failure(E)
}
