//
//  MarketSayfasi.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class MarketSayfasi: UIViewController {
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let altView : UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let topView : UIView = {
           let view = UIView()
           view.backgroundColor = .customYellow()
           view.heightAnchor.constraint(equalToConstant: 50).isActive = true
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    let btnLeft : UIButton = {
           let btn = UIButton(type: .system)
           btn.setImage(UIImage(named: "ic_back_dark"), for: .normal)
           btn.addTarget(self, action: #selector(btnLeftAction), for: .touchUpInside)
           btn.translatesAutoresizingMaskIntoConstraints = false
           return btn
       }()
    
    let btnFavori : UIButton = {
           let btn = UIButton(type: .system)
           btn.setImage(UIImage(named: "ic_favoriteicondark"), for: .normal)
           btn.addTarget(self, action: #selector(btnFavoriAction), for: .touchUpInside)
           btn.translatesAutoresizingMaskIntoConstraints = false
           return btn
       }()
    
    let imgUrun : UIImageView = {
       let img = UIImageView()
        img.backgroundColor = .white
        img.translatesAutoresizingMaskIntoConstraints = false
        img.widthAnchor.constraint(equalToConstant: 90).isActive = true
        img.heightAnchor.constraint(equalToConstant: 90).isActive = true
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.layer.borderColor = UIColor.customYellow().cgColor
        img.layer.borderWidth = 2
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
        
        let viewSV = UIStackView(arrangedSubviews: [ustView,altView])
        viewSV.axis = .vertical
        
        view.addSubview(viewSV)
        ustView.addSubview(topView)
        topView.addSubview(btnLeft)
        topView.addSubview(btnFavori)
        
    
        
        _ = viewSV.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = topView.anchor(top: ustView.topAnchor, bottom: nil, leading: ustView.leadingAnchor, trailing: ustView.trailingAnchor)
        btnLeft.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: topView.leftAnchor,constant: 5).isActive = true
        btnFavori.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnFavori.rightAnchor.constraint(equalTo: topView.rightAnchor,constant: -5).isActive = true
        
        
        
        
        
        
        
    }
    
    
    
    
    @objc func btnLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnFavoriAction() {
        print("favori")
    }
    

   

}
