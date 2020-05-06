//
//  ViewController.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/23/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class SplashView: UIViewController {
    
    //MARK: Properties
    let imgLogo = UIImageView(image: UIImage(named: ""))
    
    let homebar = HomeBar()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
        
        //MARK: addSubview
        view.addSubview(imgLogo)
        
        //MARK: anchor
        imgLogo.merkezKonumlamdirmaSuperView(boyut: CGSize(width: 120, height: 80))
        
       
        
        
    }
    
    
}

