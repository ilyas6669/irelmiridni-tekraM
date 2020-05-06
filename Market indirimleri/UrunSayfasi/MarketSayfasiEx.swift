//
//  MarketSayfasiEx.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/4/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class MarketSayfasiEx: UIViewController {
    
    
    let topView : UIView = {
           let view = UIView()
           view.backgroundColor = .customYellow()
           view.heightAnchor.constraint(equalToConstant: 50).isActive = true
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    let aciklamaView : UIView = {
           let view = UIView()
           view.backgroundColor = .customWhite()
           //view.heightAnchor.constraint(equalToConstant: 250).isActive = true
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let marketableview = MarketTableView()
        self.addChild(marketableview)
        view.addSubview(marketableview.tableView)
        
        aciklamaView.frame = CGRect(x: 0, y: 50, width: view.frame.width, height: 250)
        
       
        view.addSubview(aciklamaView)
        //aciklamaView.addSubview(topView)
        
        
        //_ = aciklamaView.anchor(top: topView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        //_ = aciklamaView.anchor(top: aciklamaView.topAnchor, bottom: nil, leading: aciklamaView.leadingAnchor, trailing: aciklamaView.trailingAnchor)
        
        //aciklamaView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true

        //marketableview.topView = topView
        marketableview.aciklamaView = aciklamaView
    }
    

   

}
