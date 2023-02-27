//
//  LayoutAttributesAnimator.swift
//  AnimatedCollectionViewLayout
//
//  Created by Ibragim Assaibuldayev on 20.02.2023.
//


import UIKit

public protocol LayoutAttributesAnimator {
    func animate(collectionView: UICollectionView, attributes: AnimatedCollectionViewLayoutAttributes)
}
