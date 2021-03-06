//
//  Home2.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/22/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds
import SDWebImage

class Home2: UIViewController {
    
    
    
    var countryList = [Resultt]() //market
    var idArray = [String]()
    
    var countryList2 = [Resulttt]() //product
    
    var photoList = [Resullt]()
    var swipecontrol = true
    
    @IBOutlet weak var ustView: UIView!
    
    @IBOutlet weak var imgReklam: UIImageView!
    
    @IBOutlet weak var lblMarket: UILabel!
    
    @IBOutlet weak var marketCollectionView: UICollectionView!
    
    @IBOutlet weak var lblFiyat: UILabel!
    
    @IBOutlet weak var fiyatlarCollectionView: UICollectionView!
    
    @IBOutlet weak var lblTop: UILabel!
    
//    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
//    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var activityIndicator2 : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
   
    
    var refreshControl : UIRefreshControl = {
           let refreshControl = UIRefreshControl()
           refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
           return refreshControl
       }()
    
    
    var oldContentOffset = CGPoint.zero
    
    var btnUp : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "up-arrow"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("test", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutDuzenle()
        collectionViewDuzenle()
        favoriKontrol()
        veriCekFoto()
        
        view.addSubview(activityIndicator)
        activityIndicator.merkezKonumlamdirmaSuperView()
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator2)
        activityIndicator2.merkezKonumlamdirmaSuperView()
        activityIndicator2.startAnimating()
        
         fiyatlarCollectionView.refreshControl = refreshControl
        
      
      
        
        
    }
    
    @objc private func refresh(sender:UIRefreshControl) {
        sender.endRefreshing()
        
        if swipecontrol {
            swipecontrol = false
            favoriKontrol()
        }
        
    }
    
    func favoriKontrol() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let context = appDelegate.persistentContainer.viewContext

               let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteStore")
               fetchRequest.returnsObjectsAsFaults = false

               do {
                   let results = try context.fetch(fetchRequest)

                   if results.count == 0 {
                       print("Nicatalibli")
                       veriCekMarket()
                       veriCekUrun()

                       activityIndicator.startAnimating()
                       activityIndicator2.startAnimating()
                       //refreshControlAction()
                   }else {
                       print("Nicatalibli")
                       favoriveriCekMarket()
                       favoriveriCekUrun()

                       activityIndicator.startAnimating()
                       activityIndicator2.startAnimating()
                       //refreshControlAction()
                   }

               } catch {
                   print("error")
               }



               
    }
    
    
    
    func layoutDuzenle() {
        view.backgroundColor = .customYellow()
         imgReklam.contentMode = .scaleAspectFill
        fiyatlarCollectionView.backgroundColor = .customWhite()
        marketCollectionView.backgroundColor = .customWhite()
        lblTop.textColor = .black
               lblTop.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 24)
    }
    
    func collectionViewDuzenle() {
        
        marketCollectionView.delegate = self
                 marketCollectionView.dataSource = self
                 marketCollectionView.register(UINib(nibName: "MarketCell", bundle: nil), forCellWithReuseIdentifier: "MarketCell")

                 if let layout = marketCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                     layout.itemSize = CGSize(width: 100, height: 100)
                     layout.minimumLineSpacing = 10
                     layout.minimumInteritemSpacing = 5
                     layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                    
                 }

        
        
        fiyatlarCollectionView.delegate = self
        fiyatlarCollectionView.dataSource = self
        fiyatlarCollectionView.register(UINib(nibName: "FiyatCell", bundle: nil), forCellWithReuseIdentifier: "FiyatCell")
        
        if let layout = fiyatlarCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width, height: 334)
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
                  marketCollectionView.reloadData()

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
                                    self.activityIndicator2.stopAnimating()
                                    
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
            marketCollectionView.reloadData()
            
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
                        self.marketCollectionView.reloadData()
                        self.activityIndicator2.stopAnimating()
                        
                    }
                    
                    
                } catch let jsonError {
                    print("Error serializing json:", jsonError)
                }
            }.resume()
           
            
        }
        
        func favoriveriCekUrun() {
            
            
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
              let context = appDelegate.persistentContainer.viewContext
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteStore")
              fetchRequest.returnsObjectsAsFaults = false
              
            do {
                let results = try context.fetch(fetchRequest)
                
                countryList2.removeAll(keepingCapacity: false)
                self.fiyatlarCollectionView.reloadData()


                
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
                                    self.activityIndicator.stopAnimating()
                                    self.swipecontrol = true
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
            self.fiyatlarCollectionView.reloadData()
            
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
                        self.activityIndicator.stopAnimating()
                        self.lblFiyat.text = "\(selectcounrty) market indirimleri "
                        self.swipecontrol = true

                    }
                    
                    
                    //bulardaki apiden gelen verilerdi
                    
                    
                } catch let jsonError {
                    print("Error serializing json:", jsonError)
                    
                    
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
    
    
    
    @IBAction func searchButton(_ sender: Any) {
         tabBarController?.selectedIndex = 1
    }
    
    
    
    
}

extension Home2 : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.marketCollectionView {
            return countryList.count
        }
        return countryList2.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if collectionView == self.marketCollectionView {
            let cell1 = marketCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketCell", for: indexPath) as! MarketCell
            cell1.lblIsim.text = countryList[indexPath.row].name
            cell1.imgUrun.sd_setImage(with: URL(string: "\(countryList[indexPath.row].image.imageDefault)"))
            return cell1
            
            
        }else {
        
            let cell2 = fiyatlarCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
            
           if indexPath.row % 9 == 0 && indexPath.row != 0 {
            
            cell2.lblIsim.isHidden = true
            cell2.lblFiyat.isHidden = true
            cell2.lblIsim2.isHidden = true
            cell2.imgUrun.isHidden = true
            cell2.lblTarih.isHidden = true
            cell2.bannerVIew.isHidden = false
            cell2.bannerVIew.adUnitID = "ca-app-pub-3774834754218485/5943173506"
            cell2.bannerVIew.rootViewController = self
            cell2.bannerVIew.load(GADRequest())
            
                return cell2
           }else{
        
            cell2.lblIsim.isHidden = false
                        cell2.lblFiyat.isHidden = false
                        cell2.lblIsim2.isHidden = false
                        cell2.imgUrun.isHidden = false
                        cell2.lblTarih.isHidden = false
                        cell2.bannerVIew.isHidden = true
            
                
                    cell2.lblIsim.text = countryList2[indexPath.row].name //
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
                            //bu urunlerin oldugu list hansidi ? sen duzgun ad veremmirsende buna country nedi ala :D
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
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.marketCollectionView {

           let storeid = countryList[indexPath.row].id

            let urunSayfasi = MarketSayfasi()
            urunSayfasi.itemid = "\(storeid)"
            urunSayfasi.modalPresentationStyle = .fullScreen
            present(urunSayfasi, animated: true, completion: nil)
            
//            let storyboard: UIStoryboard = UIStoryboard (name: "Main", bundle: nil)
//                   let vc: MarketlerSayfasi = storyboard.instantiateViewController(withIdentifier: "MarketlerSayfasi") as! MarketlerSayfasi
//                   vc.modalPresentationStyle = .fullScreen
//                    vc.itemid = "\(storeid)"
//                   self.present(vc, animated: true, completion: nil)
            
        }else{
            let productid =  countryList2[indexPath.row].id
            
            let urunSayfasi = UrunSayfasi()
            urunSayfasi.itemid = "\(productid)"
            urunSayfasi.modalPresentationStyle = .fullScreen
            present(urunSayfasi, animated: true, completion: nil)
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

           
           if (indexPath.row == 0 || indexPath.row == 1 ){
          
          
             
           }else{
           

       }

    
   
    }
    
}


extension Home2 : TabBarReselectHandling {
    func handleReselect() {
      
        
//        let topOffest:CGPoint = CGPoint(x: 0,y: -self.fiyatlarCollectionView.contentInset.top-412)
//        fiyatlarCollectionView.setContentOffset(CGPoint, animated: true)
//        self.fiyatlarCollectionView.resetScrollPositionToTop()
        self.fiyatlarCollectionView?.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath,
                                                  at: .top,
                animated: true)
        
    }
    
    
    
    
}

extension UIScrollView {
    /// Sets content offset to the top.
    func resetScrollPositionToTop() {
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
}

