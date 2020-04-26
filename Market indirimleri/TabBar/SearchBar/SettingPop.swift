//
//  SettingPop.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class SettingPop: UIView {
    
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ortaView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ortaView2 : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let altView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let ustLbl : UILabel = {
          let lbl = UILabel()
           lbl.textColor = .black
           lbl.textAlignment = .center
           lbl.text = "Mağaza veya ürün\narayabilirsiniz"
           lbl.numberOfLines = 2
           return lbl
       }()
       
       let ortaLbl : UILabel = {
          let lbl = UILabel()
           lbl.textColor = .black
           lbl.textAlignment = .center
           lbl.text = "Mağaza ara"
           lbl.numberOfLines = 2
           lbl.font = UIFont.boldSystemFont(ofSize: 15)
           return lbl
       }()
    
    let ortaLbl2 : UILabel = {
             let lbl = UILabel()
              lbl.textColor = .black
              lbl.textAlignment = .center
              lbl.text = "Ürün ara"
              lbl.numberOfLines = 2
              lbl.font = UIFont.boldSystemFont(ofSize: 15)
              return lbl
          }()
    
    
    let btnSwitch : UISwitch = {
          let btn = UISwitch()
           btn.onTintColor = .customYellow()
           btn.thumbTintColor = .black
           btn.addTarget(self, action: #selector(btnSwitchAction), for: .touchUpInside)
           btn.translatesAutoresizingMaskIntoConstraints = false
           return btn
       }()
    
    let btnSwitch2 : UISwitch = {
             let btn = UISwitch()
        //btn.setOn(false, animated: true)
              btn.onTintColor = .customYellow()
              btn.thumbTintColor = .black
              btn.addTarget(self, action: #selector(btnSwitchAction2), for: .touchUpInside)
              btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isOn = false
              return btn
          }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let viewSV = UIStackView(arrangedSubviews: [ustView,ortaView,ortaView2,altView])
               viewSV.distribution = .fillEqually
               viewSV.axis = .vertical
        
         addSubview(viewSV)
        
        
        
        
         _ = viewSV.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        
        
    }
    
    @objc func btnSwitchAction() {
        
    }
    
    @objc func btnSwitchAction2() {
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
