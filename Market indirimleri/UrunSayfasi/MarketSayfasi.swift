//
//  MarketSayfasi.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class MarketSayfasi: UIViewController {
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+1000)
    
    lazy var scrolView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .customWhite()
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.frame.size = contentViewSize
        return view
    }()
    
    let aciklamaView : UIView = {
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
    
    let ortaView : UIView = {
       let view = UIView()
        view.backgroundColor = .customWhite()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
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
        lbl.text = "Label Label Label Label Label Label Label Label Label LabelLabel abel LabelLabel Label Label Label Ll Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label LabelLabel abel LabelLabel Label Label Label Ll Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label Label LabelLabel abel LabelLabel Label Label Label Ll Label Label Label Label Label Label Label Label Label Label"
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
        serach.placeholder = "Arama Yap"
        return serach
    }()
    
    
    fileprivate let urunlerCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .red
        return cv
    }()
    
    var itemid = ""
    
  
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
        
        
        let ortaViewSV = UIStackView(arrangedSubviews: [lblAciklama,searchBar])
        ortaViewSV.axis = .vertical
        ortaViewSV.spacing = 0
        
        
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        view.addSubview(topView)
        containerView.addSubview(ortaView)
        ortaView.addSubview(ortaViewSV)
        topView.addSubview(btnLeft)
        topView.addSubview(btnFavori)
        view.addSubview(imgUrun)
        containerView.addSubview(urunlerCollectionView)
       
        
        _ = scrolView.anchor(top: topView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
         _ = topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = ortaView.anchor(top: containerView.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        _ = ortaViewSV.anchor(top: topView.bottomAnchor, bottom: ortaView.bottomAnchor, leading: ortaView.leadingAnchor, trailing: ortaView.trailingAnchor)
        _ = lblAciklama.topAnchor.constraint(equalTo: imgUrun.bottomAnchor).isActive = true
        btnLeft.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: topView.leftAnchor,constant: 5).isActive = true
        btnFavori.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnFavori.rightAnchor.constraint(equalTo: topView.rightAnchor,constant: -5).isActive = true
        imgUrun.centerYAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        imgUrun.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        _ = urunlerCollectionView.anchor(top: ortaViewSV.bottomAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
     
      
        
        
    }
    
   
   
    
    
    @objc func btnLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnFavoriAction() {
        print("favori")
    }
    
   
    
    
    
}
