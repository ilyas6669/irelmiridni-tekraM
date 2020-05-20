//
//  HomeBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
import GoogleMobileAds

class HomeBar: UIViewController {
    //MARK: scrollView
    var countryList = [Resultt]() //market
    var idArray = [String]()
    
    var countryList2 = [Resulttt]() //product
    
    var photoList = [Resullt]()
    
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
       
       lazy var scrolView: UIScrollView = {
           let view = UIScrollView(frame: .zero)
           view.backgroundColor = .customYellow()
           view.frame = self.view.bounds
           view.contentSize = contentViewSize
           view.autoresizingMask = .flexibleHeight
           view.showsHorizontalScrollIndicator = true
           view.bounces = true
           return view
       }()
       
       lazy var containerView : UIView = {
           let view = UIView()
           view.backgroundColor = .customYellow()
           view.frame.size = contentViewSize
           return view
       }()
 
    
    //MARK: properties
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let ortaView1 : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 160).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let ortaView2 : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 145).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customWhite()
        return view
    }()
    
    let altView : UIView = {
        let view = UIView()
        //view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customWhite()
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
    
    let imgReklam : UIImageView = {
        let img = UIImageView(image: UIImage(named: ""))
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 160).isActive = true
        return img
    }()
    
    let lblMarket : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        return lbl
    }()
    
    fileprivate let marketCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        cv.backgroundColor = .customWhite()
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let lblFiyat : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        return lbl
    }()
    
    fileprivate let fiyatlarCollectionView : UICollectionView = {
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
    
    var activityIndicator2 : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var refreshControl : UIRefreshControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
        layoutDuzenle()
        collectionViewDuzenle()
        veriCekFoto()
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



        refreshControlAction()


        
    }
    
    func layoutDuzenle() {
           
           view.addSubview(scrolView)
           scrolView.addSubview(containerView)
           containerView.addSubview(ustView)
           ustView.addSubview(lblTop)
           ustView.addSubview(btnTopSearch)
           containerView.addSubview(ortaView1)
           ortaView1.addSubview(imgReklam)
           containerView.addSubview(ortaView2)
           ortaView2.addSubview(lblMarket)
           ortaView2.addSubview(marketCollectionView)
           containerView.addSubview(altView)
           altView.addSubview(lblFiyat)
           altView.addSubview(fiyatlarCollectionView)
           fiyatlarCollectionView.addSubview(activityIndicator)
           marketCollectionView.addSubview(activityIndicator2)


           //MARK: constraint
        
           _ = ustView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
           lblTop.merkezKonumlamdirmaSuperView()
           btnTopSearch.merkezYSuperView()
           btnTopSearch.leadingAnchor.constraint(equalTo: ustView.leadingAnchor,constant: 5).isActive = true
           _ = ortaView1.anchor(top: ustView.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
           _ = imgReklam.anchor(top: ustView.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)

           _ = ortaView2.anchor(top: ortaView1.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
           _ = lblMarket.anchor(top: ortaView2.topAnchor, bottom: nil, leading: ortaView2.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 0, right: 0))
           _ = marketCollectionView.anchor(top: lblMarket.bottomAnchor, bottom: ortaView2.bottomAnchor, leading: ortaView2.leadingAnchor, trailing: ortaView2.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
           _ = altView.anchor(top: ortaView2.bottomAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)

           _ = lblFiyat.anchor(top: ortaView2.bottomAnchor, bottom: nil, leading: altView.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 0, right: 0))
           _ = fiyatlarCollectionView.anchor(top: lblFiyat.bottomAnchor, bottom: containerView.bottomAnchor, leading: altView.leadingAnchor, trailing: altView.trailingAnchor)


           activityIndicator.centerXAnchor.constraint(equalTo: fiyatlarCollectionView.centerXAnchor).isActive = true
           activityIndicator.topAnchor.constraint(equalTo: fiyatlarCollectionView.topAnchor,constant: 100).isActive = true

           activityIndicator2.centerXAnchor.constraint(equalTo: marketCollectionView.centerXAnchor).isActive = true
           activityIndicator2.topAnchor.constraint(equalTo: marketCollectionView.topAnchor,constant: 50).isActive = true
           
           
           
       }
       
       func collectionViewDuzenle() {
           marketCollectionView.delegate = self
           marketCollectionView.dataSource = self
           marketCollectionView.register(UINib(nibName: "MarketCell", bundle: nil), forCellWithReuseIdentifier: "MarketCell")
           
           
           
           fiyatlarCollectionView.delegate = self
           fiyatlarCollectionView.dataSource = self
           fiyatlarCollectionView.register(UINib(nibName: "FiyatCell", bundle: nil), forCellWithReuseIdentifier: "FiyatCell")
           
           if let layout = marketCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               layout.itemSize = CGSize(width: 100, height: 100)
               layout.minimumLineSpacing = 10
               layout.minimumInteritemSpacing = 5
               layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
           }

           
           if let layout = fiyatlarCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
               layout.itemSize = CGSize(width: view.frame.width, height: 334)
               layout.minimumLineSpacing = 10
               layout.minimumInteritemSpacing = 5
               layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
           }
           
       }
    
    
    func refreshControlAction() {
        
        scrolView.alwaysBounceVertical = true
        scrolView.bounces = true
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.scrolView.addSubview(refreshControl)
        
    }
    
    @objc func didPullToRefresh() {
        refreshControl.endRefreshing()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                      let context = appDelegate.persistentContainer.viewContext
                      
                      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteStore")
                      fetchRequest.returnsObjectsAsFaults = false
                      
                      do {
                          let results = try context.fetch(fetchRequest)
                          
                          if results.count == 0 {
                              veriCekMarket()
                              veriCekUrun()
                              
                              activityIndicator.startAnimating()
                              activityIndicator2.startAnimating()
                              //refreshControlAction()
                          }else {
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
                    self.activityIndicator.stopAnimating()
                    self.lblFiyat.text = "\(selectcounrty) market indirimleri "
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



extension HomeBar : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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
            
            if indexPath.row % 10 == 1{
                
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
            //
            let cell2 = fiyatlarCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
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
                
         //qoymamisam
            
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.marketCollectionView {
            
            let storeid = countryList[indexPath.row].id
            
            let urunSayfasi = MarketSayfasi()
            urunSayfasi.itemid = "\(storeid)"
            urunSayfasi.modalPresentationStyle = .fullScreen
            present(urunSayfasi, animated: true, completion: nil)
            
        }else{
            let productid =  countryList2[indexPath.row].id
            
            let urunSayfasi = UrunSayfasi()
            urunSayfasi.itemid = "\(productid)"
            urunSayfasi.modalPresentationStyle = .fullScreen
            present(urunSayfasi, animated: true, completion: nil)
            
        }
        
        
    }
    
    
}

extension UIScrollView {
    
    func resizeScrollViewContentSize() {
        
        var contentRect = CGRect.zero
        
        for view in self.subviews {
            
            contentRect = contentRect.union(view.frame)
            
        }
        
        self.contentSize = contentRect.size
        
    }
    
}
