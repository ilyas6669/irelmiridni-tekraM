//
//  StatusBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/25/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

extension UIViewController {
    func statusBarColorChange(){

           if #available(iOS 13.0, *) {

                   let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
               statusBar.backgroundColor = .customYellow()
                   statusBar.tag = 100
                   UIApplication.shared.keyWindow?.addSubview(statusBar)

           } else {

                   let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
               statusBar?.backgroundColor = .customYellow()

               }
           }
    
    func removeStatusBar(){

        if #available(iOS 13.0, *) {

            UIApplication.shared.keyWindow?.viewWithTag(100)?.removeFromSuperview()

        }
    }
    
    
    
}
