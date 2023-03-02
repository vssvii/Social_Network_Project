//
//  Extensions.swift
//  Social_Network_Project
//
//  Created by Developer on 05.02.2023.
//

import UIKit
import Photos

typealias Tint = UIColor

extension Tint {
    static let dark = UIColor(hex: "#2B3940")
    static let textGray = UIColor(hex: "#7E8183")
    static let gray = UIColor(hex: "#AAB0B4")
    static let textOrange = UIColor(hex: "#F69707")
    static let orange = UIColor(hex: "#FF9E45")
    static let blue = UIColor(hex: "#0863EB")
    static let redOrange = UIColor.rgb(from: 0xe95950)
}


func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
    let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline), NSAttributedString.Key.foregroundColor: UIColor.purple]
    let subtitleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .subheadline)]

    let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
    let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)

    titleString.append(subtitleString)

    return titleString
}

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
    
    class func rgb(from hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((hex & 0x00FF00) >> 8) / 0xFF
        let blue = CGFloat(hex & 0x0000FF) / 0xFF
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
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
    
    struct ActivityIndicator {
        static var isEnabled = false
        static var style = _style
        static var view = _view
        
        static var _style: UIActivityIndicatorView.Style {
            if #available(iOS 13.0, *) {
                return .large
            }else {
                return .whiteLarge
            }
        }
        
        static var _view: UIActivityIndicatorView {
            if #available(iOS 13.0, *) {
                return UIActivityIndicatorView(style: .large)
            }else {
                return UIActivityIndicatorView(style: .whiteLarge)
            }
        }
    }
    
    //MARK: Public Vars
    public var isActivityEnabled: Bool {
        get {
            guard let value = objc_getAssociatedObject(self, &ActivityIndicator.isEnabled) as? Bool else {
                return false
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &ActivityIndicator.isEnabled, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public var activityStyle: UIActivityIndicatorView.Style {
        get{
            guard let value = objc_getAssociatedObject(self, &ActivityIndicator.style) as? UIActivityIndicatorView.Style else {
                if #available(iOS 13.0, *) {
                    return .large
                }else {
                    return .whiteLarge
                }
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &ActivityIndicator.style, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public var activityIndicator: UIActivityIndicatorView {
        get {
            guard let value = objc_getAssociatedObject(self, &ActivityIndicator.view) as? UIActivityIndicatorView else {
                if #available(iOS 13.0, *) {
                    return UIActivityIndicatorView(style: .large)
                }else {
                    return UIActivityIndicatorView(style: .whiteLarge)
                }
            }
            return value
        }
        set(newValue) {
            let activityView = newValue
            activityView.hidesWhenStopped = true
            objc_setAssociatedObject(self, &ActivityIndicator.view, activityView, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //MARK: - Private methods
    func showActivityIndicator() {
        if isActivityEnabled {
            var isActivityIndicatorFound = false
            DispatchQueue.main.async {
                self.backgroundColor = .black
                self.activityIndicator = UIActivityIndicatorView(style: self.activityStyle)
                self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                if self.subviews.isEmpty {
                    isActivityIndicatorFound = false
                    self.addSubview(self.activityIndicator)
                    
                } else {
                    for view in self.subviews {
                        if !view.isKind(of: UIActivityIndicatorView.self) {
                            isActivityIndicatorFound = false
                            self.addSubview(self.activityIndicator)
                            break
                        } else {
                            isActivityIndicatorFound = true
                        }
                    }
                }
                if !isActivityIndicatorFound {
                    NSLayoutConstraint.activate([
                        self.activityIndicator.igCenterXAnchor.constraint(equalTo: self.igCenterXAnchor),
                        self.activityIndicator.igCenterYAnchor.constraint(equalTo: self.igCenterYAnchor)
                        ])
                }
                self.activityIndicator.startAnimating()
            }
        }
    }
    
    func hideActivityIndicator() {
        if isActivityEnabled {
            DispatchQueue.main.async {
                self.backgroundColor = UIColor.white
                self.subviews.forEach({ (view) in
                    if let av = view as? UIActivityIndicatorView {
                        av.stopAnimating()
                    }
                })
            }
        }
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


extension Date {
    
    
    func toString( dateFormat format  : String, kzTimeZone: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "language_date_locale".localized)
        if kzTimeZone {
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Almaty")
        }
        return dateFormatter.string(from: self)
    }
}


extension UIView {
    
    var igLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        }
        return self.leftAnchor
    }
    var igRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        }
        return self.rightAnchor
    }
    var igTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }
    var igBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
    var igCenterXAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.centerXAnchor
        }
        return self.centerXAnchor
    }
    var igCenterYAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.centerYAnchor
        }
        return self.centerYAnchor
    }
    var width: CGFloat {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.layoutFrame.width
        }
        return frame.width
    }
    var height: CGFloat {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.layoutFrame.height
        }
        return frame.height
    }
}

extension Int {
    var toFloat: CGFloat {
        return CGFloat(self)
    }
    
    func countLabelLines(label: UILabel)->Int{

        if let text = label.text{
            // cast text to NSString so we can use sizeWithAttributes
            var myText = text as NSString
            //A Paragraph that we use to set the lineBreakMode.
            var paragraph = NSMutableParagraphStyle()
            //Set the lineBreakMode to wordWrapping
            paragraph.lineBreakMode = NSLineBreakMode.byWordWrapping

            //Calculate the size of your UILabel by using the systemfont and the paragraph we created before. Edit the font and replace it with yours if you use another
            var labelSize = myText.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17), NSAttributedString.Key.paragraphStyle : paragraph.copy()])

            //Now we return the amount of lines using the ceil method
            var lines = ceil(CGFloat(labelSize.height) / label.font.lineHeight)
            return Int(lines)
        }

        return 0

    }
}

extension Array {
     func sortedArrayByPosition() -> [Element] {
        return sorted(by: { (obj1 : Element, obj2 : Element) -> Bool in
            
            let view1 = obj1 as! UIView
            let view2 = obj2 as! UIView
            
            let x1 = view1.frame.minX
            let y1 = view1.frame.minY
            let x2 = view2.frame.minX
            let y2 = view2.frame.minY
            
            if y1 != y2 {
                return y1 < y2
            } else {
                return x1 < x2
            }
        })
    }
}
