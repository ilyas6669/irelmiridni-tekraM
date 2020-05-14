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
    
    var activityIndicator : UIActivityIndicatorView = {
           var indicator = UIActivityIndicatorView()
           indicator.hidesWhenStopped = true
           indicator.style = .medium
           indicator.color = .black
           indicator.translatesAutoresizingMaskIntoConstraints = false
           return indicator
       }()
    
    var refreshControl : UIRefreshControl = {
          let refreshControl = UIRefreshControl()
          refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
          return refreshControl
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
        urunlerCollectionView.addSubview(activityIndicator)
        
        //MARK: constraint
        _ = viewTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        lblTop.merkezKonumlamdirmaSuperView()
        
        btnTopLeft.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor).isActive = true
        btnTopLeft.leftAnchor.constraint(equalTo: viewTop.leftAnchor,constant: 10).isActive = true
        
        _ = urunlerCollectionView.anchor(top: viewTop.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        activityIndicator.centerXAnchor.constraint(equalTo: urunlerCollectionView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: urunlerCollectionView.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        
        
    }
    
    func duzenleCollectionView() {
        urunlerCollectionView.delegate = self
        urunlerCollectionView.dataSource = self
        urunlerCollectionView.register(UINib(nibName: "FiyatCell", bundle: nil), forCellWithReuseIdentifier: "FiyatCell")
        urunlerCollectionView.refreshControl = refreshControl
        
        if let layout = urunlerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                   layout.itemSize = CGSize(width: view.frame.width, height: 334)
                   layout.minimumLineSpacing = 10
                   layout.minimumInteritemSpacing = 10
                   layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
               }
      
       
        
    }
    
    @objc private func refresh(sender:UIRefreshControl) {
             sender.endRefreshing()
            veriCekUrun()
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
                       self.activityIndicator.stopAnimating()
                       
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
    //yetim ne erroru link atbsane o link acmr ba var o singleproduct
    
    
}


extension Urunler : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell1 = urunlerCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
        cell1.lblIsim.text = countryList2[indexPath.row].name
        cell1.lblFiyat.text = countryList2[indexPath.row].price
        cell1.imgUrun.sd_setImage(with: URL(string: "\(countryList2[indexPath.row].image.imageDefault)"))
        let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(countryList2[indexPath.row].storeID)?format=json"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
            
            do {
                let welcomee = try JSONDecoder().decode(SingleStore.self, from: data)
                
                DispatchQueue.main.async {
                    cell1.lblIsim2.text = welcomee.name
                    
                }
                
            } catch let jsonError {print("Error serializing json:", jsonError)}
            
            
        }.resume()
        
        
        //"2020-05-13"
        let isoDate = countryList2[indexPath.row].validDates[1]
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:isoDate)
        
        let currentdate = Date()
        
        var counter = datesRange(from: currentdate, to: date!).count
        if counter == 0 {
            cell1.lblTarih.text = "Bugün son gün!"
        }else if counter > 0 {
            cell1.lblTarih.text = "\(counter) gün kaldı"
        }else {
            cell1.lblTarih.text = "Bitti"
        }
        

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
                cell1.imgLiked.tag = 1
                cell1.imgLiked.isHidden = false
            }else{
                cell1.imgLiked.tag = 0
                cell1.imgLiked.isHidden = true
            }
            
            
        } catch {}
                  
        
        cell1.btnTapAction = {
               () in
            print("test")
           
            let tagstatus = cell1.imgLiked.tag
            
            if tagstatus == 0 { //favori degil ise
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                let favoriteproduct = NSEntityDescription.insertNewObject(forEntityName: "FavoriteProduct", into: context)
               
                favoriteproduct.setValue("\(self.countryList2[indexPath.row].id)", forKey: "id")
                
                cell1.imgLiked.tag = 1
                cell1.imgLiked.isHidden = false
                
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

                    cell1.imgLiked.tag = 0
                    cell1.imgLiked.isHidden = true
                    
                    do {
                        try context.save()
                    } catch {
                        print("bir hata var")
                    }
                    
                } catch {}
                
                
            }
            
            
        }
        
        
        return cell1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productid =  countryList2[indexPath.row].id
        
        let urunSayfasi = UrunSayfasi()
        urunSayfasi.itemid = "\(productid)"
        urunSayfasi.modalPresentationStyle = .fullScreen
        present(urunSayfasi, animated: true, completion: nil)
    }
    
    
    
}
