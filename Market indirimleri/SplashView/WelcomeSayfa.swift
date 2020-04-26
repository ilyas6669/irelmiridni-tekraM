//
//  WelcomeSayfa.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class WelcomeSayfa: UICollectionViewCell {
    
     let image1 = UIImageView(image: #imageLiteral(resourceName: "walkthrough1"))
    
     let lbl1 : UILabel = {
        let lbl = UILabel()
        lbl.text = "Merhaba!"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.font = UIFont.systemFont(ofSize: 25)
        return lbl
    }()
    
    
    

    override init(frame: CGRect) {
    super.init(frame: frame)
        //image1.heightAnchor.constraint(equalToConstant: 400).isActive = true
        //image1.widthAnchor.constraint(equalToConstant: 300).isActive = true

        self.backgroundColor = .customYellow()
        
       
        
        
        addSubview(lbl1)
        
        addSubview(image1)
        
        
        _ = lbl1.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 40, bottom: 120, right: 40))
        //image1.merkezKonumlamdirmaSuperView()
       
        _ = image1.anchor(top: safeAreaLayoutGuide.topAnchor, bottom: lbl1.topAnchor, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 20, bottom: 10, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
   
}

