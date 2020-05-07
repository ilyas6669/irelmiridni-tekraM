//
//  Urunler.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

class Urunler: UIViewController {
    
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
        lbl.text = "Ürünler"
        return lbl
    }()
    
    let btnTopLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ic_back_dark"), for: .normal)
        btn.addTarget(self, action: #selector(btnTopLeftAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        layoutDuzenle()
        duzenleCollectionView()
        veriCekUrun()
        
        
    }
    
    func layoutDuzenle() {
        
        //MARK: addSubview
        view.addSubview(viewTop)
        viewTop.addSubview(lblTop)
        view.addSubview(btnTopLeft)
        view.addSubview(urunlerCollectionView)
        
        //MARK: constraint
        _ = viewTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        lblTop.merkezKonumlamdirmaSuperView()
        
        btnTopLeft.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor).isActive = true
        btnTopLeft.leftAnchor.constraint(equalTo: viewTop.leftAnchor,constant: 10).isActive = true
        
        _ = urunlerCollectionView.anchor(top: viewTop.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        
        
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
           
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
                 let context = appDelegate.persistentContainer.viewContext
                 
                 let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
                 fetchRequest.returnsObjectsAsFaults = false
                 
                 var selectcounrty = ""
                 var selectid = ""
                 
                 do {
                     let results = try context.fetch(fetchRequest)
                     
                     for result in results as! [NSManagedObject] {
                         if let id = result.value(forKey: "id") as? String {
                              selectid = id
                         }
                         if let name = result.value(forKey: "name") as? String {
                             selectcounrty = name
                         }
                     }
                     
                 } catch {
                     print("error")
                 }
           
           let jsonUrlString = "https://marketindirimleri.com/api/v1/products/?city=\(selectid)"
           guard let url = URL(string: jsonUrlString) else {return}
           
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               //perhaps check err
               guard let data = data else {return}
               
               do {
                               
                   let welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                   
                   DispatchQueue.main.async {
                       
                       self.countryList2 = welcomee.results
                       self.countryList2.shuffle()
                       self.urunlerCollectionView.reloadData()
                       //self.activityIndicator.stopAnimating()
                       
                   }
                   
                   
                   //bulardaki apiden gelen verilerdi
                           
                   
               } catch let jsonError {
                   print("Error serializing json:", jsonError)
                   
                   
               }
               
               
           }.resume()
           
           
           
           
           
       }
       
    
    
    
    @objc func btnTopLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension Urunler : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = urunlerCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
        cell.lblIsim.text = countryList2[indexPath.row].name
        cell.lblFiyat.text = countryList2[indexPath.row].price
        cell.imgUrun.sd_setImage(with: URL(string: "\(countryList2[indexPath.row].image.imageDefault)"))
        let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(countryList2[indexPath.row].storeID)?format=json"
         let url = URL(string: jsonUrlString)
        
         URLSession.shared.dataTask(with: url!) { (data, response, error) in
             //perhaps check err
             guard let data = data else {return}
             
             do {
                 let welcomee = try JSONDecoder().decode(SingleStore.self, from: data)
                 
                 DispatchQueue.main.async {
                     cell.lblIsim2.text = welcomee.name
                     
                 }
                 
             } catch let jsonError {print("Error serializing json:", jsonError)}
             
             
         }.resume()
                   return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let urunSayfasi = UrunSayfasi()
        urunSayfasi.modalPresentationStyle = .fullScreen
        present(urunSayfasi, animated: true, completion: nil)
    }
    
    
    
}
