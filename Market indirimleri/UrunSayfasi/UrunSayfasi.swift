//
//  UrunSayfasi.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class UrunSayfasi: UIViewController {
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let altView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imgUrun : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let btnLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ic_back_yellow"), for: .normal)
        btn.addTarget(self, action: #selector(btnLeftAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnFavori : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ic_favoriteiconyellow"), for: .normal)
        btn.addTarget(self, action: #selector(btnFavoriAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let lblIsim : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.text = "Label Label Label Label Label Label Label Label "
        lbl.numberOfLines = 4
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblFiyat : UILabel = {
           let lbl = UILabel()
           lbl.textColor = .customYellow()
           lbl.textAlignment = .left
           lbl.text = "100.00"
           lbl.numberOfLines = 2
           lbl.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 22)
           lbl.translatesAutoresizingMaskIntoConstraints = false
           return lbl
       }()
    
    let lblAciklama : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        lbl.text = "Label Label Label Label Label Label Label Label Label LabelLabel abel LabelLabel Label Label Label Label Label Label Label Label Label.00Label LabelLabel LabelLabel LabelLabel LabelLabel Label"
        lbl.numberOfLines = 30
        lbl.translatesAutoresizingMaskIntoConstraints = false
         lbl.font = UIFont.boldSystemFont(ofSize: 17)
        return lbl
    }()
    
    let lblIsim2 : UILabel = {
           let lbl = UILabel()
           lbl.textColor = .darkGray
           lbl.textAlignment = .left
           lbl.text = "Label Label LabelLabel Label"
           lbl.numberOfLines = 2
           lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
           return lbl
       }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
        
        let lblSV = UIStackView(arrangedSubviews: [lblIsim,lblFiyat,lblAciklama,lblIsim2])
        lblSV.axis = .vertical
        lblSV.spacing = 0
        
        view.addSubview(ustView)
        ustView.addSubview(imgUrun)
        ustView.addSubview(btnLeft)
        ustView.addSubview(btnFavori)
        view.addSubview(altView)
        altView.addSubview(lblSV)
        
        
        _ = ustView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = imgUrun.anchor(top: ustView.topAnchor, bottom: ustView.bottomAnchor, leading: ustView.leadingAnchor, trailing: ustView.trailingAnchor)
        _ = btnLeft.anchor(top: ustView.topAnchor, bottom: nil, leading: ustView.leadingAnchor, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0))
         _ = btnFavori.anchor(top: ustView.topAnchor, bottom: nil, leading: nil, trailing: ustView.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 10))
        _ = altView.anchor(top: ustView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = lblSV.anchor(top: ustView.bottomAnchor, bottom: nil, leading: altView.leadingAnchor, trailing: altView.trailingAnchor,padding: .init(top: 0, left: 5, bottom: 0, right: 5))

      
    }
    

    @objc func btnLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnFavoriAction() {
        print("favori")
    }
    
    
    
}
