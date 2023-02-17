//
//  Extensions.swift
//  Social_Network_Project
//
//  Created by Developer on 05.02.2023.
//

import UIKit
import Photos

extension UIColor {
    
    
    public convenience init(hex: String) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 1

        let hexColor = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        var valid = false

        if scanner.scanHexInt64(&hexNumber) {
            if hexColor.count == 8 {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
                valid = true
            }
            else if hexColor.count == 6 {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x0000ff) / 255
                valid = true
            }
        }

        #if DEBUG
            assert(valid, "UIColor initialized with invalid hex string")
        #endif

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}


extension UIImageView {
  func fetchImageAsset(_ asset: PHAsset?, targetSize size: CGSize, contentMode: PHImageContentMode = .aspectFill, options: PHImageRequestOptions? = nil, completionHandler: ((Bool) -> Void)?) {
    // 1
    guard let asset = asset else {
      completionHandler?(false)
      return
    }
    // 2
    let resultHandler: (UIImage?, [AnyHashable: Any]?) -> Void = { image, info in
      self.image = image
      completionHandler?(true)
    }
    // 3
    PHImageManager.default().requestImage(
      for: asset,
      targetSize: size,
      contentMode: contentMode,
      options: options,
      resultHandler: resultHandler)
  }
}

extension UIViewController {
    
    typealias Callback = () -> Void
    
    func presentAlert(title: String? = nil, message: String? = nil, completion: (Callback)? = nil) {
        let title = title ?? "try_again"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { _ in
            guard let completion = completion else { return }
            completion()
        }))
        present(alert, animated: true)
    }
    
}
