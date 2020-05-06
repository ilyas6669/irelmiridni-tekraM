//
//  CartBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class CartBar: UIViewController {
    
    var countryList2 = [Resulttt]()
    var idArray = [Int]()
    
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
        lbl.text = "Beğendiğim Ürünler"
        return lbl
    }()
    
    let viewBulunmadi : UIView = {
       let view = UIView()
        view.backgroundColor = .customWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imgBulunmadi : UIImageView = {
       let img = UIImageView(image: UIImage(named: "ic_norecord_dark"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.heightAnchor.constraint(equalToConstant: 250).isActive = true
        img.widthAnchor.constraint(equalToConstant: 250).isActive = true
        return img
    }()
    
    let lblBUlunmadi : UILabel = {
       let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Hiç bir şey bulunamadı"
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
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
        
        view.backgroundColor = .customYellow()
        
        
        //MARK: addSubview
        view.addSubview(viewTop)
        viewTop.addSubview(lblTop)
        view.addSubview(viewBulunmadi)
        viewBulunmadi.addSubview(imgBulunmadi)
        viewBulunmadi.addSubview(lblBUlunmadi)
        view.addSubview(urunlerCollectionView)
        
        //MARK: constraint
        _ = viewTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        lblTop.merkezKonumlamdirmaSuperView()
        _ = viewBulunmadi.anchor(top: viewTop.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        imgBulunmadi.merkezKonumlamdirmaSuperView()
        _ = lblBUlunmadi.anchor(top: imgBulunmadi.bottomAnchor, bottom: nil, leading: viewBulunmadi.leadingAnchor, trailing: viewBulunmadi.trailingAnchor)
        _ = urunlerCollectionView.anchor(top: viewTop.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
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
           let jsonUrlString = "https://marketindirimleri.com/api/v1/products/?city=\(idArray.last!)"
           print("Nicatalibli:\(jsonUrlString)")
           print("Nicataliblii:\(idArray.last!)")
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
           
           
           DispatchQueue.main.async {

                                self.urunlerCollectionView.reloadData()

                                }
           
           
       }

    
   
    
}

extension CartBar : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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
