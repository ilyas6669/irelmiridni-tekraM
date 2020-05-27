//
//  TabBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData

protocol TabBarReselectHandling {
    func handleReselect()
}

class TabBar: UITabBarController, UITabBarControllerDelegate{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
    }
    
    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController
    ) -> Bool {
        if tabBarController.selectedViewController === viewController,
            let handler = viewController as? TabBarReselectHandling {
            // NOTE: viewController in line above might be a UINavigationController,
            // in which case you need to access its contents
            handler.handleReselect()
        }
        
        return true
    }
    
   

    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
        if let homebar = viewController as? Home2  {
          
            
            
        }
      
        
        
        if let cartbar = viewController as? CartBar {
            cartbar.countryList2.removeAll()
            cartbar.swapList.removeAll()
            cartbar.veriCekUrun()
            //buradaaaa
        } else if let profilbar = viewController as? ProfilBar {
            profilbar.lblBegendigimUrunDeyis()
            profilbar.lblBegendigimMarketDeyis()
        }
        
        //        if viewController is CartBar {
        //            print("First tab")
        //        } else if viewController is SearchBar {
        //            print("Second tab")
        //        }
    }
    
    
    
}
