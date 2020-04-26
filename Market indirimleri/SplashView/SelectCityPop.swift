//
//  SelectCityPop.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class SelectCityPop: UIView {

    
    let viewSehirSec : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return view
    }()
    
    let lblSehirSec : UILabel = {
       let lbl = UILabel()
        lbl.text = "Şehir Seç"
        lbl.textColor = .black
        lbl.textAlignment = . center
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let searchBar : UISearchBar = {
       let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    let altView : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view.layer.shadowColor = UIColor.customWhite().cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let btnTamam : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("TAMAM", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(btnTamamAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let sehirTableView = UITableView()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        
        addSubview(viewSehirSec)
        viewSehirSec.addSubview(lblSehirSec)
        addSubview(searchBar)
        addSubview(altView)
        altView.addSubview(btnTamam)
        addSubview(sehirTableView)
        
        
        _ = viewSehirSec.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor)
        lblSehirSec.merkezKonumlamdirmaSuperView()
        _ = searchBar.anchor(top: viewSehirSec.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor)
        _ = altView.anchor(top: nil, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        btnTamam.centerYAnchor.constraint(equalTo: altView.centerYAnchor).isActive = true
        btnTamam.rightAnchor.constraint(equalTo: altView.rightAnchor,constant: -10).isActive = true
        _ = sehirTableView.anchor(top: searchBar.bottomAnchor, bottom: altView.topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        
        sehirTableView.separatorColor = .white
        sehirTableView.delegate = self
        sehirTableView.dataSource = self
        sehirTableView.register(UINib(nibName: "SehirlerCel", bundle: nil), forCellReuseIdentifier: "SehirlerCel")
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnTamamAction() {
        print("tamam")
    }
    
    

}


extension SelectCityPop : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sehirTableView.dequeueReusableCell(withIdentifier: "SehirlerCel", for: indexPath) as! SehirlerCel
        cell.imgSucces.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("test")
        sehirTableView.reloadData()
        let cell = sehirTableView.cellForRow(at: indexPath) as! SehirlerCel
        cell.imgSucces.isHidden = false
      
        
    }
    
    
}
