//
//  TabBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData

class TabBar: UITabBarController, UITabBarControllerDelegate{
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
       
    }
    

    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
        if let homebar = viewController as? Home  {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteStore")
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count == 0 {
                   
                    homebar.veriCekUrun()
                
                    homebar.activityIndicator.startAnimating()
                   
                    //refreshControlAction()
                }else {
                   
                    homebar.favoriveriCekUrun()
                    
                 
                    
                    homebar.activityIndicator.startAnimating()
                   
                    //refreshControlAction()
                }
                
            } catch {
                print("error")
            }
        }
      
        
        
        if let cartbar = viewController as? CartBar {
            cartbar.veriCekUrun()
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
