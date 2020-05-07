//
//  AramaPop.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class AramaPop: UIView {

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
        lbl.text = "Istanbul veya tüm şehirler için arama yapa\nbilirsin."
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let ortaLbl : UILabel = {
       let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.text = "Tüm şehirler için ara"
        lbl.numberOfLines = 2
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    let btnSwitch : UISwitch = {
       let btn = UISwitch()
         btn.setOn(true, animated: true)
        btn.onTintColor = .customYellow()
        btn.thumbTintColor = .black
        btn.addTarget(self, action: #selector(btnSwitchAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnTamam : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .customYellow()
        btn.setTitle("TAMAM", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
//        layer.shadowColor = UIColor.customWhite().cgColor
//        layer.shadowOpacity = 1
//        layer.shadowOffset = CGSize.zero
//        layer.shadowRadius = 2
        
        let viewSV = UIStackView(arrangedSubviews: [ustView,ortaView,altView])
        viewSV.distribution = .fillEqually
        viewSV.axis = .vertical
        
        addSubview(viewSV)
        ustView.addSubview(ustLbl)
        ortaView.addSubview(ortaLbl)
        ortaView.addSubview(btnSwitch)
        altView.addSubview(btnTamam)
        
        _ = viewSV.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        
        ustLbl.merkezKonumlamdirmaSuperView()
        ortaLbl.merkezKonumlamdirmaSuperView()
        btnTamam.merkezKonumlamdirmaSuperView()
        _ = btnTamam.anchor(top: altView.topAnchor, bottom: altView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: 5, left: 25, bottom: 15, right: 25))
        
        btnSwitch.centerYAnchor.constraint(equalTo: ortaView.centerYAnchor).isActive = true
        btnSwitch.rightAnchor.constraint(equalTo: ortaView.rightAnchor,constant: -10).isActive = true
        
    
        
        
        
        
    }
    @objc func btnSwitchAction() {
        print("switch")
    }
    
   
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
