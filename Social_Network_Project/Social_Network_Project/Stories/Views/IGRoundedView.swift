//
//  IGRoundedView.swift
//  IGRoundedView
//
// Created by Developer on 20.02.2023.
//

import Foundation
import UIKit

//@note:Recommended Size: CGSize(width:70,height:70)
struct Attributes {
    let borderWidth:CGFloat = 2.0
    let borderColor = UIColor.white
    let backgroundColor = Tint.orange
    let size = CGSize(width:68,height:68)
}

class IGRoundedView: UIView {
    private var attributes:Attributes = Attributes()
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderWidth = (attributes.borderWidth)
        iv.layer.borderColor = attributes.borderColor.cgColor
        iv.clipsToBounds = true
        return iv
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = attributes.backgroundColor
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
        backgroundColor = attributes.backgroundColor
        addSubview(imageView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        imageView.frame = CGRect(x:1,y:1,width:(attributes.size.width)-2,height:attributes.size.height-2)
        imageView.layer.cornerRadius = imageView.frame.height/2
    }
}

extension IGRoundedView {
    func enableBorder(enabled: Bool = true) {
        if enabled {
            layer.borderColor = UIColor.clear.cgColor
            layer.borderWidth = 0
        }else {
            layer.borderColor = attributes.borderColor.cgColor
            layer.borderWidth = attributes.borderWidth
        }
    }
}
