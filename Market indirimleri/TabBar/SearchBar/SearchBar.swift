//
//  SearchBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import PopupDialog

class SearchBar: UIViewController {
   
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
        lbl.text = "Mağaza Ara"
        return lbl
    }()
    
    
    
    let btnTopLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "mapicon_dark"), for: .normal)
        btn.addTarget(self, action: #selector(btnTopLeftAction), for: .touchUpInside)
        return btn
    }()
    
    let btnTopSetting : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ic_setting_black"), for: .normal)
        btn.addTarget(self, action: #selector(btnTopSettingAction), for: .touchUpInside)
        return btn
    }()
    
    let viewMagazaAra : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblMagazaAra : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Mağaza Ara"
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        return lbl
    }()
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    let marketlerTableView = UITableView()
    
    let aramaPop : AramaPop = {
        let arama = AramaPop()
        arama.translatesAutoresizingMaskIntoConstraints = false
        arama.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return arama
    }()
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pickerView = UIPickerView()
  
    let array = ["Mağaza ara","Ürün ara"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .customYellow()
        
        //MARK: addSubview
        view.addSubview(viewTop)
        viewTop.addSubview(lblTop)
        viewTop.addSubview(btnTopLeft)
        viewTop.addSubview(btnTopSetting)
        view.addSubview(searchBar)
        view.addSubview(viewMagazaAra)
        viewMagazaAra.addSubview(lblMagazaAra)
        view.addSubview(marketlerTableView)
        
        
        
        //MARK: constraint
        _ = viewTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        lblTop.merkezKonumlamdirmaSuperView()
        btnTopLeft.merkezYSuperView()
        btnTopLeft.leadingAnchor.constraint(equalTo: viewTop.leadingAnchor,constant: 5).isActive = true
        btnTopSetting.merkezYSuperView()
        btnTopSetting.trailingAnchor.constraint(equalTo: viewTop.trailingAnchor,constant: -5).isActive = true
        _ = searchBar.anchor(top: viewTop.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = viewMagazaAra.anchor(top: searchBar.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        lblMagazaAra.merkezKonumlamdirmaSuperView()
        _ = marketlerTableView.anchor(top: searchBar.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        
        marketlerTableView.delegate = self
        marketlerTableView.dataSource = self
        marketlerTableView.register(UINib(nibName: "MarketlerCel", bundle: nil), forCellReuseIdentifier: "MarketlerCel")
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(gestureREcongizer)
        
        pickerView.dataSource = self
        pickerView.delegate = self
       
      
        
        
    }
    
    @objc func btnTopLeftAction() {
        view.addSubview(aramaPop)
        aramaPop.merkezKonumlamdirmaSuperView()
        _ = aramaPop.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        aramaPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        aramaPop.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.aramaPop.alpha = 1
            self.aramaPop.transform = CGAffineTransform.identity
        }
        
    }
    
    @objc func btnTopSettingAction() {
        print("right")
    }
    
    @objc func handleDismissal() {
        UIView.animate(withDuration: 0.3, animations: {
            self.aramaPop.alpha = 0
            self.visualEffectView.alpha = 0
            self.aramaPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.aramaPop.removeFromSuperview()
        }
    }
    
    
    
    
    
    
}

extension SearchBar : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = marketlerTableView.dequeueReusableCell(withIdentifier: "MarketlerCel", for: indexPath) as! MarketlerCel
        return cell
    }
    
    
}

extension SearchBar : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    
    
}
