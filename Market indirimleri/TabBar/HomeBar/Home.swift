//
//  Home.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/21/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds
import SDWebImage

class Home: UIViewController {
    
     var countryList2 = [Resulttt]()
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let lblTop : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 24)
        lbl.text = "Marketindirimleri.com"
        return lbl
    }()
    
    let btnTopSearch : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "search-1"), for: .normal)
        btn.addTarget(self, action: #selector(btnSearchAction), for: .touchUpInside)
        return btn
    }()
    
    fileprivate let fiyatlarCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .customWhite()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
        addSubview()
        addConstraint()
        collectionViewDuzenle()
        favoriveriCekUrun()
        veriCekUrun()
        
        
    }
    
    
    func addSubview() {
        view.addSubview(ustView)
        view.addSubview(fiyatlarCollectionView)
        ustView.addSubview(lblTop)
        ustView.addSubview(btnTopSearch)
        
    }
    
    func addConstraint() {
        _ = ustView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        lblTop.merkezKonumlamdirmaSuperView()
        btnTopSearch.merkezYSuperView()
        btnTopSearch.leadingAnchor.constraint(equalTo: ustView.leadingAnchor,constant: 5).isActive = true
        _ = fiyatlarCollectionView.anchor(top: ustView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
    }
    
    
    func collectionViewDuzenle() {
        fiyatlarCollectionView.delegate = self
        fiyatlarCollectionView.dataSource = self
        fiyatlarCollectionView.register(UINib(nibName: "FiyatCell", bundle: nil), forCellWithReuseIdentifier: "FiyatCell")
        fiyatlarCollectionView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
        
        if let layout = fiyatlarCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width, height: 334)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
        
    }
    
    func favoriveriCekUrun() {
           
           
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
             let context = appDelegate.persistentContainer.viewContext
             let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteStore")
             fetchRequest.returnsObjectsAsFaults = false
             
           do {
               let results = try context.fetch(fetchRequest)
               
               countryList2.removeAll(keepingCapacity: false)

               
               for result in results as! [NSManagedObject] {
                   if let id = result.value(forKey: "id") as? String {
                    
                       let jsonUrlString = "https://marketindirimleri.com/api/v1/products/?store=\(id)&format=json"
                       guard let url = URL(string: jsonUrlString) else {return}
                       
                       
                       URLSession.shared.dataTask(with: url) { (data, response, error) in
                           //perhaps check err
                           guard let data = data else {return}
                           
                           do {
                               
                               let welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                               
                               DispatchQueue.main.async {
                                                                   
                                   self.countryList2.append(contentsOf: welcomee.results)
                                   self.countryList2.shuffle()
                                   self.fiyatlarCollectionView.reloadData()
                                  
                               }
                               
                               
                               //bulardaki apiden gelen verilerdi
                               
                               
                           } catch let jsonError {
                               print("Error serializing json:", jsonError)
                               
                               
                           }
                           
                           
                       }.resume()
                       
                   }
               }
               
           } catch {
               print("error")
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
           
           countryList2.removeAll(keepingCapacity: false)
           
           let jsonUrlString = "https://marketindirimleri.com/api/v1/products/?city=\(selectid)&format=json"
           guard let url = URL(string: jsonUrlString) else {return}
           
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               //perhaps check err
               guard let data = data else {return}
               
               do {
                   
                   let welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                   
                   DispatchQueue.main.async {
                       
                       self.countryList2 = welcomee.results
                       self.countryList2.shuffle()
                       self.fiyatlarCollectionView.reloadData()
                      
                   }
                   
                   
                   //bulardaki apiden gelen verilerdi
                   
                   
               } catch let jsonError {
                   print("Error serializing json:", jsonError)
                   
                   
               }
               
               
           }.resume()
           
           
       }
       
    
    @objc func btnSearchAction() {
           tabBarController?.selectedIndex = 1
       }
    
    
}


extension Home : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell2 = fiyatlarCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
        
        if indexPath.row % 9 == 0 && indexPath.row != 0 {
            
            let cell3 = fiyatlarCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
            cell3.lblIsim.isHidden = true
            cell3.lblFiyat.isHidden = true
            cell3.lblIsim2.isHidden = true
            cell3.imgUrun.isHidden = true
            cell3.lblTarih.isHidden = true
            var bannerView = GADBannerView()
            cell3.addSubview(bannerView)
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            bannerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            bannerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
            bannerView.centerXAnchor.constraint(equalTo: cell3.centerXAnchor).isActive = true
            bannerView.centerYAnchor.constraint(equalTo: cell3.centerYAnchor).isActive = true
            bannerView.adUnitID = "ca-app-pub-3774834754218485/5943173506"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            return cell3
            
        }
    
        cell2.lblIsim.text = countryList2[indexPath.row].name
        cell2.lblFiyat.text = countryList2[indexPath.row].price
        cell2.imgUrun.sd_setImage(with: URL(string: "\(countryList2[indexPath.row].image.imageDefault)"))
        
        
        //"2020-05-13"
        let isoDate = countryList2[indexPath.row].validDates[1]
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:isoDate)
        
        let currentdate = Date()
        
        var counter = datesRange(from: currentdate, to: date!).count
        if counter == 0 {
            cell2.lblTarih.text = "Bugün son gün!"
        }else if counter > 0 {
            cell2.lblTarih.text = "\(counter) gün kaldı"
        }else {
            cell2.lblTarih.text = "Bitti"
        }
        
       
        
        let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(countryList2[indexPath.row].storeID)?format=json"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
            
            do {
                let welcomee = try JSONDecoder().decode(SingleStore.self, from: data)
                
                DispatchQueue.main.async {
                    cell2.lblIsim2.text = welcomee.name
                    
                }
                
            } catch let jsonError {print("Error serializing json:", jsonError)}
            
            
        }.resume()
        
        ///--------------------------FAVORI CONTROL----------------------------------------------------------------
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteProduct")
        fetchRequest.returnsObjectsAsFaults = false
        
        var favoriteproductcontrol = false
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let id = result.value(forKey: "id") as? String {
                    
                    if id == "\(self.countryList2[indexPath.row].id)" {
                        favoriteproductcontrol = true
                        break
                    }else{
                        favoriteproductcontrol = false
                    }
                    
                }
                
            }
            if favoriteproductcontrol{
                cell2.imgLiked.tag = 1
                cell2.imgLiked.isHidden = false
            }else{
                cell2.imgLiked.tag = 0
                cell2.imgLiked.isHidden = true
            }
            
            
        } catch {}
        
        
        cell2.btnTapAction = {
            () in
            print("test")
            
            
            let tagstatus = cell2.imgLiked.tag
            
            if tagstatus == 0 { //favori degil ise
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let favoriteproduct = NSEntityDescription.insertNewObject(forEntityName: "FavoriteProduct", into: context)
                
                favoriteproduct.setValue("\(self.countryList2[indexPath.row].id)", forKey: "id")
                
                cell2.imgLiked.tag = 1
                cell2.imgLiked.isHidden = false
                
                do {
                    try context.save()
                } catch {
                    print("bir hata var")
                }
                
            }else{ //favori ise
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteProduct")
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                    let results = try context.fetch(fetchRequest)
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let id = result.value(forKey: "id") as? String {
                            
                            if id == "\(self.countryList2[indexPath.row].id)" {
                                context.delete(result as NSManagedObject)
                            }
                            
                        }
                        
                    }
                    
                    cell2.imgLiked.tag = 0
                    cell2.imgLiked.isHidden = true
                    
                    do {
                        try context.save()
                    } catch {
                        print("bir hata var")
                    }
                    
                } catch {}
                
                
            }
            
            
        }
        
        
        
        return cell2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productid =  countryList2[indexPath.row].id
        let urunSayfasi = UrunSayfasi()
        urunSayfasi.itemid = "\(productid)"
        urunSayfasi.modalPresentationStyle = .fullScreen
        present(urunSayfasi, animated: true, completion: nil)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = fiyatlarCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath) as! CollectionReusableView
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 332)
    }
    
    
}
