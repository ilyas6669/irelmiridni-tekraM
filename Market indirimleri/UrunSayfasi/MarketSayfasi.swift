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
        //view.heightAnchor.constraint(equalToConstant: 250).isActive = true
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
    
    let lblAciklama : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.text = "Label Label Label Label Label Label Label Label Label LabelLabel abel LabelLabel Label Label Label Label Label Label Label Label Label.00Label LabelLabel LabelLabel LabelLabel LabelLabel Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label"
        lbl.numberOfLines = 30
        lbl.translatesAutoresizingMaskIntoConstraints = false
        //lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let searchBar : UISearchBar = {
       let serach = UISearchBar()
        serach.backgroundColor = .white
        return serach
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customWhite()
        
        let viewSV = UIStackView(arrangedSubviews: [lblAciklama,altView])
        viewSV.axis = .vertical
        //viewSV.distribution = .fillEqually
        
        view.addSubview(viewSV)
        ustView.addSubview(topView)
        view.addSubview(topView)
        topView.addSubview(btnLeft)
        topView.addSubview(btnFavori)
        view.addSubview(imgUrun)
        //ustView.addSubview(lblAciklama)
        altView.addSubview(searchBar)
        
    
        
        _ = viewSV.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        _ = topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        btnLeft.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: topView.leftAnchor,constant: 5).isActive = true
        btnFavori.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnFavori.rightAnchor.constraint(equalTo: topView.rightAnchor,constant: -5).isActive = true
        
        _ = lblAciklama.anchor(top: imgUrun.bottomAnchor, bottom: altView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        
        imgUrun.centerYAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        imgUrun.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
        _ = searchBar.anchor(top: altView.topAnchor, bottom: nil, leading: altView.leadingAnchor, trailing: altView.trailingAnchor)
        
        
        
        
    }
    
    
    
    
    @objc func btnLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnFavoriAction() {
        print("favori")
    }
    

   

}
