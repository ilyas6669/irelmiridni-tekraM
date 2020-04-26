//
//  ProfilBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class ProfilBar: UIViewController {
    
    
    //MARK: properties
    let viewTop : UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return view
    }()
    
    let lblTop : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 24)
        lbl.text = "Profilim"
        return lbl
    }()
    
    let ustView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customYellow()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
        return view
    }()
    
    let lblSehir : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 29)
        lbl.text = "Istanbul"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let altView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customYellow2()
        
        return view
    }()
    
    let btnMarket : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("0 Market", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(btnMarketAction), for: .touchUpInside)
        return btn
    }()
    
    let btnUrun : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("0 Ürün", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(btnUrunAction), for: .touchUpInside)
        return btn
    }()
    
    let altView2 : UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customWhite()
        return view
    }()
    
    let btnBegendigimMarket : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        
        btn.setTitle("Beğendiğim Marketler", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.addTarget(self, action: #selector(btnBegeniMarketAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return btn
    }()
    
    let btnBegendigimUrun : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        
        btn.setTitle("Beğendiğim Ürünler", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.addTarget(self, action: #selector(btnBegendigimUrunAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return btn
    }()
    
    let imgBegendigimMarket : UIImageView = {
        let img = UIImageView(image: UIImage(named: "favoriteProducts"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let imgBegendigimUrun : UIImageView = {
        let img = UIImageView(image: UIImage(named: "favorite-grey"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblBegendigimMarket : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.text = "0"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblBegendigimUrun : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.text = "0"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customYellow()
        layoutDuzenle()
        
        
        
        
    }
    
    func layoutDuzenle() {
        
        //MARK: stackView
        let btnSV = UIStackView(arrangedSubviews: [btnMarket,btnUrun])
        btnSV.axis = .horizontal
        btnSV.distribution = .fillEqually
        
        let btn2SV = UIStackView(arrangedSubviews: [btnBegendigimMarket,btnBegendigimUrun])
        btn2SV.axis = .vertical
        btn2SV.distribution = .fillEqually
        btn2SV.spacing = 15
        
        //MARK: addSubview
        view.addSubview(viewTop)
        viewTop.addSubview(lblTop)
        view.addSubview(ustView)
        ustView.addSubview(lblSehir)
        view.addSubview(altView)
        altView.addSubview(btnSV)
        view.addSubview(altView2)
        altView2.addSubview(btn2SV)
        btnBegendigimMarket.addSubview(imgBegendigimMarket)
        btnBegendigimMarket.addSubview(lblBegendigimMarket)
        btnBegendigimUrun.addSubview(imgBegendigimUrun)
        btnBegendigimUrun.addSubview(lblBegendigimUrun)
        
        //MARK: constraint
        _ = viewTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        lblTop.merkezKonumlamdirmaSuperView()
        
        _ = ustView.anchor(top: viewTop.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        lblSehir.merkezKonumlamdirmaSuperView()
        
        _ = altView.anchor(top: ustView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        _ = btnSV.anchor(top: altView.topAnchor, bottom: altView.bottomAnchor, leading: altView.leadingAnchor, trailing: altView.trailingAnchor)
        
        _ = altView2.anchor(top: altView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        _ = btn2SV.anchor(top: altView.bottomAnchor, bottom: nil, leading: altView2.leadingAnchor, trailing: altView2.trailingAnchor,padding: .init(top: 20, left: 10, bottom: 0, right: 10))
        
        imgBegendigimMarket.centerYAnchor.constraint(equalTo: btnBegendigimMarket.centerYAnchor).isActive = true
        imgBegendigimMarket.leftAnchor.constraint(equalTo: btnBegendigimMarket.leftAnchor,constant: 10).isActive = true
        
        lblBegendigimMarket.centerYAnchor.constraint(equalTo: btnBegendigimMarket.centerYAnchor).isActive = true
        lblBegendigimMarket.rightAnchor.constraint(equalTo: btnBegendigimMarket.rightAnchor,constant: -12).isActive = true
        
        imgBegendigimUrun.centerYAnchor.constraint(equalTo: btnBegendigimUrun.centerYAnchor).isActive = true
        imgBegendigimUrun.leftAnchor.constraint(equalTo: btnBegendigimUrun.leftAnchor,constant: 10).isActive = true
        
        lblBegendigimUrun.centerYAnchor.constraint(equalTo: btnBegendigimUrun.centerYAnchor).isActive = true
        lblBegendigimUrun.rightAnchor.constraint(equalTo: btnBegendigimUrun.rightAnchor,constant: -12).isActive = true
        
        
    }
    
    
    
    @objc func btnMarketAction() {
        let marketler = Marketler()
        marketler.modalPresentationStyle = .fullScreen
        self.present(marketler, animated: true, completion: nil)
    }
    
    @objc func btnUrunAction() {
        let urunler = Urunler()
        urunler.modalPresentationStyle = .fullScreen
        self.present(urunler, animated: true, completion: nil)
        
    }
    @objc func btnBegeniMarketAction() {
        let begendigimMarketler = BegendigimMarketler()
        begendigimMarketler.modalPresentationStyle = .fullScreen
        self.present(begendigimMarketler, animated: true, completion: nil)
    }
    
    @objc func btnBegendigimUrunAction() {
        self.tabBarController?.selectedIndex = 2
    }
    
    
    
}


