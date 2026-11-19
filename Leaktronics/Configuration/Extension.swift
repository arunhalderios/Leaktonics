//
//  Extension.swift
//  Leaktronics
//
//  Created by ivaninfotech on 4/24/20.
//  Copyright © 2020 Abhishek Mullick. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications
import SystemConfiguration

class Extension: NSObject {
    static let sharedExtension = Extension()
    
    //check if network connection can be made
    func connectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}

extension Date {
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension UIDevice {
    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS or iPhone 11 Pro"
        case iPhone_XR_11 = "iPhone XR or iPhone 11"
        case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max "
        //case iPhone_11Pro = "iPhone 11 Pro"
        case iPad_PRO = "iPad 9.7"
        case iPad_Air = "iPad Air(3rd Gen)"
        case unknown
    }
    
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR_11
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax_ProMax
        case 2048:
            return .iPad_PRO
        case 2224:
            return .iPad_PRO
        default:
            return .unknown
        }
    }
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}

extension UITextField {

    enum Direction {
        case Left
        case Right
    }

    // add image to textfield
    func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 2, y: 0, width: 25, height: 25))
        mainView.layer.cornerRadius = 0

        let view = UIView(frame: CGRect(x: 2, y: 0, width: 25, height: 25))
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 0
        view.layer.borderWidth = CGFloat(0.1)
        view.layer.borderColor = colorBorder.cgColor
        mainView.addSubview(view)

        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 12.0, y: 5.0, width: 15.0, height: 15.0)
        view.addSubview(imageView)

        let seperatorView = UIView()
        seperatorView.backgroundColor = colorSeparator
        mainView.addSubview(seperatorView)

        if(Direction.Left == direction){ // image left
            seperatorView.frame = CGRect(x: 45, y: 0, width: 1, height: 45)
            self.leftViewMode = .always
            self.leftView = mainView
        } else { // image right
            seperatorView.frame = CGRect(x: 0, y: 0, width: 1, height: 45)
            self.rightViewMode = .always
            self.rightView = mainView
        }

        self.layer.borderColor = colorBorder.cgColor
        self.layer.borderWidth = CGFloat(0.1)
        self.layer.cornerRadius = 5
    }
    
    func withoutImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
           let mainView = UIView(frame: CGRect(x: 5, y: 5, width:5, height: 5))
           mainView.layer.cornerRadius = 0

           let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
           view.backgroundColor = .white
           view.clipsToBounds = true
           view.layer.cornerRadius = 0
           view.layer.borderWidth = CGFloat(0.0)
           view.layer.borderColor = colorBorder.cgColor
           mainView.addSubview(view)

           let imageView = UIImageView(image: image)
           imageView.contentMode = .scaleAspectFit
           imageView.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)
           view.addSubview(imageView)

           let seperatorView = UIView()
           seperatorView.backgroundColor = colorSeparator
           mainView.addSubview(seperatorView)

           if(Direction.Left == direction){ // image left
               seperatorView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
               self.leftViewMode = .always
               self.leftView = mainView
           } else { // image right
               seperatorView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
               self.rightViewMode = .always
               self.rightView = mainView
           }
       }
}

extension UIColor {
    var hexString:String? {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}

extension String {
    var utfData: Data? {
        return self.data(using: .utf8)
    }
    
    var htmlToString: String {
        return attributedHtmlString?.string ?? ""
    }
    
    var attributedHtmlString: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    var htmlAttributed: (NSAttributedString?, NSDictionary?) {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return (nil, nil)
            }
            
            var dict:NSDictionary?
            dict = NSMutableDictionary()
            
            return try (NSAttributedString(data: data,
                                           options: [.documentType: NSAttributedString.DocumentType.html,
                                                     .characterEncoding: String.Encoding.utf8.rawValue],
                                           documentAttributes: &dict), dict)
        } catch {
            print("error: ", error)
            return (nil, nil)
        }
    }
    
    func htmlAttributed(using font: UIFont, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(font.pointSize)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(font.familyName), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSAttributedString? {
        do {
            let htmlCSSString = "<style>" +
                "html *" +
                "{" +
                "font-size: \(size)pt !important;" +
                "color: #\(color.hexString!) !important;" +
                "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return nil
            }
            
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
}

extension UIImageView {
    public func imageFromServerURL(urlString: String) {//, defaultImage : String?
//        if let di = defaultImage {
//            self.image = UIImage(named: di)
//        }
        print("URL: === \(urlString)")
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.contentMode = .scaleAspectFill
                let image = UIImage(data: data!)
                self.image = image
    })
        }).resume()
    }
}
