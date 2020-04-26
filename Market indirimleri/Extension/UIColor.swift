//
//  UIColor.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/23/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green : CGFloat,blue : CGFloat) -> UIColor  {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        
        
    }
}

extension UIColor {
    class func customYellow() -> UIColor {
        return UIColor(red: 250/255, green: 212/255, blue: 71/255, alpha: 1)
    }
}

extension UIColor {
    class func customWhite() -> UIColor {
        return UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
}

extension UIColor {
    class func customYellow2() -> UIColor {
        return UIColor(red: 248/255, green: 197/255, blue: 2/255, alpha: 1)
    }
}
