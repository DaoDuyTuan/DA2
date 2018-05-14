//
//  MyUI.swift
//  TutorialData
//
//  Created by Duy Tuan on 12/27/17.
//  Copyright © 2017 Duy Tuan. All rights reserved.
//

import Foundation
import UIKit

class MyUI {
    static func customButton(button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
    }
    static func customColour(red: CGFloat, green: CGFloat, blue: CGFloat, str: String, fontName: String?, size: CGFloat?) -> NSAttributedString{
        var attributes = [NSAttributedStringKey: AnyObject]()
        attributes[NSAttributedStringKey.foregroundColor] = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        if fontName != nil, size != nil {
            attributes[NSAttributedStringKey.font] = UIFont(name: fontName!, size: size!)
        }
        let attributedString = NSAttributedString(string: str, attributes: attributes)
        return attributedString
    }
    
    static func combineMultilString(str1: NSAttributedString, str2: NSAttributedString) -> NSMutableAttributedString{
        let combine = NSMutableAttributedString()
        combine.append(str1)
        combine.append(str2)
        return combine
    }
    static func formatterToCurrency(_ number: Double) -> String?{
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.numberStyle = .currency
        if let formatterUsd = formatter.string(from: number as NSNumber) {
            return formatterUsd
        }
        return nil
    }
}
