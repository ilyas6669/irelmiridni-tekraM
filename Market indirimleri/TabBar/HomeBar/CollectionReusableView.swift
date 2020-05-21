//
//  CollectionReusableView.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/21/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData

class CollectionReusableView: UICollectionReusableView {
    
    var photoList = [Resullt]()
    var idArray = [String]()
    var countryList = [Resultt]()
    
    @IBOutlet weak var imgReklam: UIImageView!
    
    @IBOutlet weak var lblMarket: UILabel!
    
    @IBOutlet weak var marketCollectionView: UICollectionView!
    
    @IBOutlet weak var lblFiyat: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutDuzenle()
        collectionViewDuzenle()
        veriCekFoto()
        favoriveriCekMarket()
        veriCekMarket()
        
        
        
    }
    
    func layoutDuzenle() {
        backgroundColor = .customWhite()
        imgReklam.contentMode = .scaleAspectFill
        marketCollectionView.backgroundColor = .customWhite()
        marketCollectionView.showsHorizontalScrollIndicator = false
        
    }
    
    func collectionViewDuzenle() {
        marketCollectionView.delegate = self
        marketCollectionView.dataSource = self
        marketCollectionView.register(UINib(nibName: "MarketCell", bundle: nil), forCellWithReuseIdentifier: "MarketCell")
        if let layout = marketCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 110, height: 110)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
        
    }
    
    func veriCekFoto() {
        let jsonUrlString = "https://marketindirimleri.com/api/v1/banners/?format=json"
        
        guard let url = URL(string: jsonUrlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
            do {
                
                let welcomee = try JSONDecoder().decode(Banner.self, from: data)
                
                DispatchQueue.main.async {
                    self.photoList = welcomee.results
                    
                    //bulardaki apiden gelen verilerdi
                    self.imgReklam.sd_setImage(with: URL(string: "\(self.photoList[0].image.imageDefault)"))
                }
                
                
                
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
        
    }
    
     func favoriveriCekMarket() {
              
              let appDelegate = UIApplication.shared.delegate as! AppDelegate
              let context = appDelegate.persistentContainer.viewContext
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteStore")
              fetchRequest.returnsObjectsAsFaults = false
              
            
            let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
            fetchRequest2.returnsObjectsAsFaults = false
            
            var selectcounrty = ""
            
            do {
                let results = try context.fetch(fetchRequest2)
                
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        selectcounrty = name
                    }
                }
                
                self.lblFiyat.text = "\(selectcounrty) market indirimleri "
                self.lblMarket.text = "\(selectcounrty) marketleri"
                      
                
            } catch {
                print("error")
            }
                
            
              do {
                  let results = try context.fetch(fetchRequest)
                
                  countryList.removeAll(keepingCapacity: false)

                  for result in results as! [NSManagedObject] {
                    if let id = result.value(forKey: "id") as? String {
                    
                        let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(id)?format=json"
                        guard let url = URL(string: jsonUrlString) else {return}
                        
                        URLSession.shared.dataTask(with: url) { (data, response, error) in
                            //perhaps check err
                            guard let data = data else {return}
                            do {
                                
                                let welcome = try JSONDecoder().decode(Resultt.self, from: data)
                                
                                DispatchQueue.main.async {
                                    
                                    self.countryList.append(welcome)
                                    
                                    self.countryList.shuffle()
    //                                self.lblMarket.text = "\(selectcounrty) marketleri"
                                    self.marketCollectionView.reloadData()
                                   
                                    
                                }
                                
                                
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
    
    func veriCekMarket() {
           
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let context = appDelegate.persistentContainer.viewContext
           
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
           fetchRequest.returnsObjectsAsFaults = false
           
           var selectcounrty = ""
           
           do {
               let results = try context.fetch(fetchRequest)
               
               for result in results as! [NSManagedObject] {
                   if let id = result.value(forKey: "id") as? String {
                       self.idArray.append(id)
                   }
                   if let name = result.value(forKey: "name") as? String {
                       selectcounrty = name
                   }
               }
               
           } catch {
               print("error")
           }
           
           countryList.removeAll(keepingCapacity: false)
           
           let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/?format=json"
           guard let url = URL(string: jsonUrlString) else {return}
           
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               //perhaps check err
               guard let data = data else {return}
               do {
                   
                   let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                   
                   DispatchQueue.main.async {
                       
                       for n in welcome.results {
                           
                           if n.cities.contains(Int(self.idArray.last!)!) {
                               self.countryList.append(n)
                           }
                           
                       }
                       
                       self.countryList.shuffle()
                       self.lblMarket.text = "\(selectcounrty) marketleri"
                       self.lblFiyat.text = "\(selectcounrty) market indirimleri "
                       self.marketCollectionView.reloadData()
                       
                   }
                   
                   
               } catch let jsonError {
                   print("Error serializing json:", jsonError)
               }
           }.resume()
          
           
       }
    
    
}

extension CollectionReusableView : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = marketCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketCell", for: indexPath) as! MarketCell
        cell1.lblIsim.text = countryList[indexPath.row].name
        cell1.imgUrun.sd_setImage(with: URL(string: "\(countryList[indexPath.row].image.imageDefault)"))
        return cell1
    }
    
    func getCurrentViewController() -> UIViewController? {
           //ios 13 control
           if let rootController = UIApplication.shared.keyWindow?.rootViewController {
               var currentController: UIViewController! = rootController
               while( currentController.presentedViewController != nil ) {
                   currentController = currentController.presentedViewController
               }
               return currentController
           }
           return nil
           
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.marketCollectionView {
            
            let storeid = countryList[indexPath.row].id
            
            let urunSayfasi = MarketSayfasi()
            urunSayfasi.itemid = "\(storeid)"
            urunSayfasi.modalPresentationStyle = .fullScreen
            let currentController = self.getCurrentViewController()
            currentController?.present(urunSayfasi, animated: true, completion: nil)
        
       }
   
}
    

}
