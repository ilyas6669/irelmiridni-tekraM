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
import GoogleMobileAds


class CartBar: UIViewController {
    
    var countryList2 = [SingleProduct]()
    var idArray = [Int]()
    
    //MARK: properties
    
    
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
    
     let urunlerCollectionView : UICollectionView = {
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
    
    var refreshControl2 : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
       
        
        
        //MARK: addSubview
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        containerView.addSubview(viewTop)
        viewTop.addSubview(lblTop)
        containerView.addSubview(viewBulunmadi)
        viewBulunmadi.addSubview(imgBulunmadi)
        viewBulunmadi.addSubview(lblBUlunmadi)
        view.addSubview(urunlerCollectionView)
        urunlerCollectionView.addSubview(activityIndicator)
        
        //MARK: constraint
        _ = viewTop.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        lblTop.merkezKonumlamdirmaSuperView()
        _ = viewBulunmadi.anchor(top: viewTop.bottomAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        imgBulunmadi.merkezKonumlamdirmaSuperView()
        _ = lblBUlunmadi.anchor(top: imgBulunmadi.bottomAnchor, bottom: nil, leading: viewBulunmadi.leadingAnchor, trailing: viewBulunmadi.trailingAnchor)
        _ = urunlerCollectionView.anchor(top: viewTop.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        activityIndicator.merkezKonumlamdirmaSuperView()
        activityIndicator.startAnimating()
        
        urunlerCollectionView.delegate = self
        urunlerCollectionView.dataSource = self
        urunlerCollectionView.register(UINib(nibName: "CartBarCell", bundle: nil), forCellWithReuseIdentifier: "CartBarCell")
        urunlerCollectionView.refreshControl = refreshControl
        
        
        if let layout = urunlerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width, height: 334)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        
        
        
        veriCekUrun()
        refreshControlAction()
        
    }
    
    @objc private func refresh(sender:UIRefreshControl) {
        sender.endRefreshing()
        veriCekUrun()
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
       veriCekUrun()
        
    }
    
    
    
    func veriCekUrun() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteProduct")
        fetchRequest.returnsObjectsAsFaults = false
        
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count == 0 {
               
                viewBulunmadi.isHidden = false
                urunlerCollectionView.isHidden = true
            }else{
                viewBulunmadi.isHidden = true
                urunlerCollectionView.isHidden = false
            }
           countryList2.removeAll(keepingCapacity: false)
                 
            for result in results as! [NSManagedObject] {
                
                if let id = result.value(forKey: "id") as? String {
                    
                    let jsonUrlString = "https://marketindirimleri.com/api/v1/products/\(id)?format=json"
                    guard let url = URL(string: jsonUrlString) else {return}
                    
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        //perhaps check err
                        guard let data = data else {return}
                        
                        do {
                            
                            let singleproduct = try JSONDecoder().decode(SingleProduct.self, from: data)
                            
                            DispatchQueue.main.async {
                                
                                
                                self.countryList2.append(singleproduct)
//                                self.countryList2.reverse()
                                self.urunlerCollectionView.reloadData()
                                self.activityIndicator.stopAnimating()
                                
                            }//reversi yox ele gor burda? ana seyfede ne dexlisi ana sayfada normal gorsenirde 10 nan bir ahahahahahah sikim zordu bele :D noldu ala silende hamisi sikdirdi yroex elaqesi yoxdu onan di elaqesi duzeldiki nese cox dimdix veziyyte olur
                            
                            
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
    
    
    
    
}

extension CartBar : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        if indexPath.row % 4 == 0 && indexPath.row != 0 {
            let cell1 = urunlerCollectionView.dequeueReusableCell(withReuseIdentifier: "CartBarCell", for: indexPath) as! CartBarCell
            cell1.lblIsim.isHidden = true
            cell1.lblFiyat.isHidden = true
            cell1.imgUrun.isHidden = true
            cell1.lblIsim2.isHidden = true
            cell1.lblTarih.isHidden = true
            var bannerView = GADBannerView()
            cell1.addSubview(bannerView)
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            bannerView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            bannerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
            bannerView.centerXAnchor.constraint(equalTo: cell1.centerXAnchor).isActive = true
            bannerView.centerYAnchor.constraint(equalTo: cell1.centerYAnchor).isActive = true
            bannerView.adUnitID = "ca-app-pub-3774834754218485/5943173506"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
            return cell1
            
            
        }
        let cell = urunlerCollectionView.dequeueReusableCell(withReuseIdentifier: "CartBarCell", for: indexPath) as! CartBarCell
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
        
        cell.btnTapAction = {
                          () in
                       print("test")
                      
                       let tagstatus = cell.imgLiked.tag
                       
                       if tagstatus == 0 {
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

                            cell.imgLiked.tag = 0
                            cell.imgLiked.isHidden = true
                            
                            do {
                                try context.save()
                            } catch {
                                print("bir hata var")
                            }
                            
                        } catch {}
                        
                        //favori degil ise
                           
                         
                           
                       }else{ //favori ise
                           let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                                    let context = appDelegate.persistentContainer.viewContext
                                                    
                                                    let favoriteproduct = NSEntityDescription.insertNewObject(forEntityName: "FavoriteProduct", into: context)
                                                    //bu urunlerin oldugu list hansidi ? sen duzgun ad veremmirsende buna country nedi ala :D
                                                    favoriteproduct.setValue("\(self.countryList2[indexPath.row].id)", forKey: "id")
                                                    
                                                    cell.imgLiked.tag = 1
                                                    cell.imgLiked.isHidden = false
                                                    
                                                    do {
                                                        try context.save()
                                                    } catch {
                                                        print("bir hata var")
                                                    }
                           
                           
                           
                       }
                       
                       
                   }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productid =  countryList2[indexPath.row].id
        
        let urunSayfasi = UrunSayfasi()
        urunSayfasi.itemid = "\(productid)"
        urunSayfasi.modalPresentationStyle = .fullScreen
        present(urunSayfasi, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
      
        //
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteProduct")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                
                if let id = result.value(forKey: "id") as? String {
                    

                        if id == "\(countryList2[indexPath.row].id)" {
                            context.delete(result as NSManagedObject)
                            countryList2.remove(at: indexPath.row)
                            urunlerCollectionView.deleteItems(at: [indexPath])
                            break
                        }
                        //gelende de 
                    
                }
                
            }
            do {
                try context.save()
            } catch {
                print("bir hata var")
            }
            
        } catch {}
                  
    }
    
    
    
}
