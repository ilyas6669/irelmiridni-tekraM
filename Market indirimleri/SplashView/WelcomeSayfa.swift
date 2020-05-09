//
//  WelcomeSayfa.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class WelcomeSayfa: UICollectionViewCell {
    
     let image1 = UIImageView(image: UIImage(named: ""))

    
     let lbl1 : UILabel = {
        let lbl = UILabel()
        lbl.text = "Ürünlerinizi listenize eklemek için çift dokunun yine listenizden çıkarmak için çift dokunun"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 5
        lbl.font = UIFont.systemFont(ofSize: 20)
        return lbl
    }()
    
    
    let lbl2 : UILabel = {
           let lbl = UILabel()
           lbl.text = "Ürünlerinizi listenize eklemek için çift\ndokunun"
           lbl.textColor = .white
           lbl.textAlignment = .center
           lbl.numberOfLines = 5
           lbl.font = UIFont.boldSystemFont(ofSize: 20)
           return lbl
       }()
    
    
    

    override init(frame: CGRect) {
    super.init(frame: frame)
        image1.heightAnchor.constraint(equalToConstant: 350).isActive = true
//        image1.widthAnchor.constraint(equalToConstant: 200).isActive = true

        self.backgroundColor = .customYellow()
         image1.translatesAutoresizingMaskIntoConstraints = false
       
        
        
        addSubview(lbl1)
        
        addSubview(image1)
        
        addSubview(lbl2)
        
         _ = lbl2.anchor(top: nil, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: 80, left: 5, bottom: 0, right: 5))
        
        image1.merkezKonumlamdirmaSuperView()
        _ = image1.anchor(top: lbl2.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        
        _ = lbl1.anchor(top: image1.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
       
      
     
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
   
}

