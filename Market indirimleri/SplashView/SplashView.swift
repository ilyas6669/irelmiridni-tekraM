//
//  ViewController.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/23/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData

class SplashView: UIViewController {
    
    //MARK: Properties
    let imgLogo = UIImageView(image: UIImage(named: "logo"))
    
    var activityIndicator : UIActivityIndicatorView = {
           var indicator = UIActivityIndicatorView()
           indicator.hidesWhenStopped = true
           indicator.style = .medium
           indicator.color = .black
           indicator.translatesAutoresizingMaskIntoConstraints = false
           return indicator
       }()
    
    let homebar = HomeBar()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
        
        //MARK: addSubview
        view.addSubview(imgLogo)
        view.addSubview(activityIndicator)
        
        //MARK: anchor
        imgLogo.merkezKonumlamdirmaSuperView(boyut: CGSize(width: 200, height: 200))
        activityIndicator.topAnchor.constraint(equalTo: imgLogo.bottomAnchor,constant: 5).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        activityIndicator.startAnimating()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        fetchRequest.returnsObjectsAsFaults = false
        
        var selectedcountryname = ""
        var selectedcountryid   = ""
        var datacontrol = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let id = result.value(forKey: "id") as? String {
                    selectedcountryid = id
                    datacontrol = true
                }
                if let name = result.value(forKey: "name") as? String {
                    selectedcountryname = name
                    datacontrol = true
                }
                
            }
            
            if datacontrol{ ///kayit olub
                
                print("Nicataliblii:Kec\(selectedcountryname) || \(selectedcountryid)")
                perform(#selector(toTabBarControllerr), with: nil,afterDelay: 2)
                
            }else{ ///kayit olmuyub
                
                print("Nicatalibli:Kecme\(selectedcountryname) || \(selectedcountryid)")
                perform(#selector(toGecisControllerr), with: nil,afterDelay: 2)
            
            }
            
        } catch {
            print("error")
        }
        
        
        
    }
    
    
    @objc func toGecisControllerr() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let signUp = GecisController(collectionViewLayout: layout)
        signUp.modalPresentationStyle = .overFullScreen
        present(signUp, animated: true, completion: nil)
    }
    
    @objc func toTabBarControllerr() {
        let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
        let vc: TabBar = storyboard.instantiateViewController(withIdentifier: "TabBar") as! TabBar
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
}

