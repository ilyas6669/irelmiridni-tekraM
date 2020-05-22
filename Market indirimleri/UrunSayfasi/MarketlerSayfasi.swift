//
//  MarketlerSayfasi.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/22/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData

class MarketlerSayfasi: UIViewController {
    
    var itemid = ""
    
    var countryList2 = [Resulttt]()
    
    var marketlist = [Market]()
    
    @IBOutlet weak var ustVieww: UIView!
    
    @IBOutlet weak var imgUrun: UIImageView!
    
    @IBOutlet weak var ortaView: UIView!
    
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var urunlerCollectionView: UICollectionView!
    
    var oldContentOffset = CGPoint.zero
    
    @IBOutlet weak var lblAciklama: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var btnFavori: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewDuzenle()
        veriCek()
        veriCekUrun()
        
        
        imgUrun.contentMode = .scaleAspectFill
        
    }
    
    
    func collectionViewDuzenle() {
        
        urunlerCollectionView.delegate = self
        urunlerCollectionView.dataSource = self
        urunlerCollectionView.register(UINib(nibName: "FiyatCell", bundle: nil), forCellWithReuseIdentifier: "FiyatCell")
        if let layout = urunlerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                  layout.itemSize = CGSize(width: view.frame.width, height: 334)
                  layout.minimumLineSpacing = 10
                  layout.minimumInteritemSpacing = 10
                  layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
              }
    }
    
    func veriCek() {
           
           let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(itemid)?format=json"
           guard let url = URL(string: jsonUrlString) else {return}
         

           URLSession.shared.dataTask(with: url) { (data, response, error) in
             
               guard let data = data else {return}
               
               do {
                   
                   let welcomee = try JSONDecoder().decode(Market.self, from: data)
                   
                   DispatchQueue.main.async {
                       

                       self.lblAciklama.text = welcomee.detail
                       self.imgUrun.sd_setImage(with: URL(string: "\(welcomee.image.imageDefault)"))
                      
                   }
                   
                  
               } catch let jsonError {
                   print("Error serializing json:", jsonError)
                   
                   
               }
               
               
           }.resume()
           
       }
       
       
       func veriCekUrun() {
          
          
           let jsonUrlString = "https://marketindirimleri.com/api/v1/products/?store=\(itemid)&format=json"
           guard let url = URL(string: jsonUrlString) else {return}
           
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               //perhaps check err
               guard let data = data else {return}
               
               do {
                   
                   let welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                   
                   DispatchQueue.main.async {
                       
                       self.countryList2 = welcomee.results
                       
                       if self.countryList2.count == 0 {

                           //MARK: urun yoxdu
                           //self.viewBulunmadi.isHidden = false
                           self.urunlerCollectionView.isHidden = true
                           print("Nicatalibli:URUNYOK")
                       }else{
                           //urun var
                           //self.viewBulunmadi.isHidden = true
                           self.urunlerCollectionView.isHidden = false
                       }
                       
                       self.countryList2.shuffle()
                       self.urunlerCollectionView.reloadData()
                       
                       
                   }
                   
                   
               } catch let jsonError {
                   print("Error serializing json:", jsonError)
                   
                   
               }
               
               
           }.resume()
           
       }
    
    
    func getitem (searchkeyword: String) {
        
        var url = ""
        
        url = "https://marketindirimleri.com/api/v1/products/?store=\(itemid)&q=\(searchkeyword)&format=json"
        
     
        guard let url2 = URL(string: url) else {return}
        
        print("Nicatalibli:\(url2)")
        
        URLSession.shared.dataTask(with: url2) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
            
            do {
                
                
                var welcomee : Welcomee!
                
                
                
                welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                
                DispatchQueue.main.async {
                    
                    
                    
                    
                    
                    
                    self.countryList2 = welcomee.results
                    
                    self.urunlerCollectionView.reloadData()
                    
                    
                    
                }
                
                
                
            } catch let jsonError {
                print("Nicatalibli:Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
        
        
    }
    
       
       
    
    
  
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let constentOffset = scrollView.contentOffset.y - oldContentOffset.y
        
        if scrollView.contentOffset.y > 0 && constentOffset > 0 {
            if topViewTopConstraint.constant > -412 {
                topViewTopConstraint.constant -= constentOffset
                scrollView.contentOffset.y -= constentOffset
                
            }
        }
        if scrollView.contentOffset.y < 0 && constentOffset < 0 {
            if topViewTopConstraint.constant < 0 {
                if topViewTopConstraint.constant - constentOffset > 0 {
                    topViewTopConstraint.constant = 0
                }else {
                    topViewTopConstraint.constant -= constentOffset
                }
                scrollView.contentOffset.y -= constentOffset
            }
        }
        oldContentOffset = scrollView.contentOffset
        
        
    }
    
    
    @IBAction func btnLeft(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnFavori(_ sender: Any) {
        let tagstatus = btnFavori.tag
              
              if tagstatus == 0 { //favori degil ise
                  
                  let appDelegate = UIApplication.shared.delegate as! AppDelegate
                  let context = appDelegate.persistentContainer.viewContext
                  
                  let favoriteproduct = NSEntityDescription.insertNewObject(forEntityName: "FavoriteStore", into: context)
                  //urunun id si nedi adi
                  favoriteproduct.setValue("\(itemid)", forKey: "id")
                  
                  btnFavori.tag = 1
                  btnFavori.setImage(UIImage(named: "ic_favoriteicondarkselected"), for: .normal)
                  
                  
                  do {
                      try context.save()
                  } catch {
                      print("bir hata var")
                  }
                  
              }else{ //favori ise
                  
                  let appDelegate = UIApplication.shared.delegate as! AppDelegate
                  let context = appDelegate.persistentContainer.viewContext
                  
                  let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteStore")
                  fetchRequest.returnsObjectsAsFaults = false
                  
                  do {
                      let results = try context.fetch(fetchRequest)
                      
                      for result in results as! [NSManagedObject] {
                          
                          if let id = result.value(forKey: "id") as? String {
                              
                              if id == "\(itemid)" {
                                  context.delete(result as NSManagedObject)
                              }
                              
                          }
                          
                      }
                      do {
                          try context.save()
                      } catch {
                          print("bir hata var")
                      }
                      
                  } catch {}
                  
                  btnFavori.tag = 0
                  btnFavori.setImage(UIImage(named: "ic_favoriteicondark"), for: .normal)
                  
              }
              
              
              
    }
    
    
}

extension MarketlerSayfasi : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = urunlerCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
        cell.lblIsim.text = countryList2[indexPath.row].name
        cell.lblFiyat.text = countryList2[indexPath.row].price
        cell.imgUrun.sd_setImage(with: URL(string: "\(countryList2[indexPath.row].image.imageDefault)"))
        //"2020-05-13"
        let isoDate = countryList2[indexPath.row].validDates[1]
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:isoDate)
        
        let currentdate = Date()
        
        var counter = datesRange(from: currentdate, to: date!).count
        if counter == 0 {
            cell.lblTarih.text = "Bugün son gün!"
        }else if counter > 0 {
            cell.lblTarih.text = "\(counter) gün kaldı"
        }else {
            cell.lblTarih.text = "Bitti"
        }
        
        
        
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
        
        let productid =  countryList2[indexPath.row].id
        
        let urunSayfasi = UrunSayfasi()
        urunSayfasi.itemid = "\(productid)"
        urunSayfasi.modalPresentationStyle = .fullScreen
        present(urunSayfasi, animated: true, completion: nil)
    }
    
}



//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderVieww", for: indexPath) as! HeaderVieww
//        return header
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return .init(width: view.frame.width, height: 57)
//    }
//



extension MarketlerSayfasi : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getitem(searchkeyword: searchBar.text!)
        searchBar.resignFirstResponder()
    }

}


