//
//  AltUrunSayfasi.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/4/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class AltUrunSayfasi: UIViewController {
    
    var countryList2 = [Resulttt]()
    var idArray = [Int]()
    
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ustImage : UIImageView = {
        let img = UIImageView(image: UIImage(named: ""))
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        //img.contentMode = .scaleAspectFill
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
        lbl.textColor = .customYellow()
        lbl.textAlignment = .center
        lbl.text = "Label Label Label Label  "
        lbl.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 22)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    fileprivate let urunlerCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .customWhite()
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutDuzenle()
        duzenleCollectionView()
        veriCekUrun()
        
        
        
        
        
        
        
    }
    
    func layoutDuzenle(){
        
        view.backgroundColor = .red
        
        view.addSubview(ustView)
        ustView.addSubview(ustImage)
        ustView.addSubview(btnLeft)
        ustView.addSubview(btnFavori)
        ustView.addSubview(lblIsim)
        view.addSubview(urunlerCollectionView)
        
        
        _ = ustView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        btnLeft.merkezYSuperView()
        btnLeft.leftAnchor.constraint(equalTo: ustView.leftAnchor,constant: 10).isActive = true
        btnFavori.merkezYSuperView()
        btnFavori.rightAnchor.constraint(equalTo: ustView.rightAnchor,constant: -10).isActive = true
        lblIsim.merkezKonumlamdirmaSuperView()
        //lblIsim.leadingAnchor.constraint(equalTo: btnLeft.trailingAnchor).isActive = true
        //lblIsim.trailingAnchor.constraint(equalTo: btnFavori.leadingAnchor).isActive = true
        _ = urunlerCollectionView.anchor(top: ustView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
    }
    
    
    
    
    func duzenleCollectionView() {
        urunlerCollectionView.delegate = self
        urunlerCollectionView.dataSource = self
        urunlerCollectionView.register(UINib(nibName: "FiyatCell", bundle: nil), forCellWithReuseIdentifier: "FiyatCell")
        
        if let layout = urunlerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width, height: 310)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        
        
        
    }
    
    func veriCekUrun() {
        let jsonUrlString = "https://marketindirimleri.com/api/v1/products/)"
        print("Nicatalibli:\(jsonUrlString)")
        //print("Nicataliblii:\(idArray.last!)")
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
            
            
            do {
                
                let welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                self.countryList2 = welcomee.results
                
                //bulardaki apiden gelen verilerdi
                print("666\(self.countryList2[0].name)")
                print("666\(self.countryList2[0].id)")
                print("666\(self.countryList2[0].image)")
                
                
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
        self.urunlerCollectionView.reloadData()
        
    }
    
    @objc func btnLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnFavoriAction() {
        print("favori")
    }
    
    
    
}


extension AltUrunSayfasi : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = urunlerCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
        cell.lblIsim.text = countryList2[indexPath.row].name
        cell.lblFiyat.text = countryList2[indexPath.row].price
        cell.imgUrun.sd_setImage(with: URL(string: "\(countryList2[indexPath.row].image.imageDefault)"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let urunSayfasi = UrunSayfasi()
        urunSayfasi.modalPresentationStyle = .fullScreen
        present(urunSayfasi, animated: true, completion: nil)
    }
    
    
}
