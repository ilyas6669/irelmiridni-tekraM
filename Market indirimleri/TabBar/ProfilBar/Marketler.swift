//
//  Marketler.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class Marketler: UIViewController {
    
    var countryList = [Resultt]()
       var idArray = [String]()
    
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
        lbl.text = "Marketler"
        return lbl
    }()
    
    let btnTopLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ic_back_dark"), for: .normal)
        btn.addTarget(self, action: #selector(btnTopLeftAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    let marketlerTableView = UITableView()
    let marketler = MarketlerCel()
    
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
        veriCekMarket()
      
        
        
    }
    
    func layoutDuzenle() {
        
        //MARK: addSubview
        view.addSubview(viewTop)
        viewTop.addSubview(lblTop)
        view.addSubview(btnTopLeft)
        view.addSubview(marketlerTableView)
        marketlerTableView.addSubview(activityIndicator)
        
        //MARK: constraint
        _ = viewTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        lblTop.merkezKonumlamdirmaSuperView()
        
        btnTopLeft.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor).isActive = true
        btnTopLeft.leftAnchor.constraint(equalTo: viewTop.leftAnchor,constant: 10).isActive = true
        
        _ = marketlerTableView.anchor(top: viewTop.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        activityIndicator.centerXAnchor.constraint(equalTo: marketlerTableView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: marketlerTableView.centerYAnchor).isActive = true
        
        activityIndicator.startAnimating()
        
    
    }
    
    func duzenleCollectionView() {
        marketlerTableView.delegate = self
        marketlerTableView.dataSource = self
        marketlerTableView.register(UINib(nibName: "MarketlerCel", bundle: nil), forCellReuseIdentifier: "MarketlerCel")
        marketlerTableView.refreshControl = refreshControl
        
    }
    
    @objc private func refresh(sender:UIRefreshControl) {
           sender.endRefreshing()
          veriCekMarket()
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
                       self.marketlerTableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    
                       
                   }
                   
                   
               } catch let jsonError {
                   print("Error serializing json:", jsonError)
               }
           }.resume()
          
           
       }
    
    
    
    @objc func btnTopLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension Marketler : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = marketlerTableView.dequeueReusableCell(withIdentifier: "MarketlerCel", for: indexPath) as! MarketlerCel
        cell.lblIsim.text = countryList[indexPath.row].name
        cell.imgUrun.sd_setImage(with: URL(string: "\(countryList[indexPath.row].image.imageDefault)"))
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        fetchRequest.returnsObjectsAsFaults = false
        
        var selectcounrty = ""
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name") as? String {
                    selectcounrty = name
                    cell.lblSehir.text = selectcounrty
                }
            }
            
        } catch {
            print("error")
        }
        
       ///--------------------------FAVORI BUTON CLICK----------------------------------------------------------------
       cell.btnTapAction = { //favori buton
           () in
           
           let tagstatus = cell.btnFavori.tag
           
           if tagstatus == 0 { //favori degil ise
               
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let context = appDelegate.persistentContainer.viewContext
               
               let favoriteproduct = NSEntityDescription.insertNewObject(forEntityName: "FavoriteStore", into: context)
               favoriteproduct.setValue("\(self.countryList[indexPath.row].id)", forKey: "id")
               
               cell.btnFavori.tag = 1
               cell.btnFavori.setImage(UIImage(named: "ic_favoriteiconyellowselected"), for: .normal)
               
               
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
                           
                           if id == "\(self.countryList[indexPath.row].id)" {
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
               
               cell.btnFavori.tag = 0
               cell.btnFavori.setImage(UIImage(named: "ic_favoriteiconyellow"), for: .normal)
               
           }
           
       }
       ///--------------------------URUN FAVORI MI CONTROL ----------------------------------------------------------------
       let fetchRequestCityFavorite = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteStore")
       fetchRequestCityFavorite.returnsObjectsAsFaults = false
       
       var favoriteproductcontrol = false
       do {
           let results = try context.fetch(fetchRequestCityFavorite)
           
           for result in results as! [NSManagedObject] {
               
               if let id = result.value(forKey: "id") as? String {
                   
                   
                   if id == "\(self.countryList[indexPath.row].id)" {
                       favoriteproductcontrol = true
                       break
                   }else{
                       favoriteproductcontrol = false
                   }
                   
               }
               
           }
           if favoriteproductcontrol{
               cell.btnFavori.tag = 1
               cell.btnFavori.setImage(UIImage(named: "ic_favoriteiconyellowselected"), for: .normal)
           }else{
               cell.btnFavori.tag = 0
               cell.btnFavori.setImage(UIImage(named: "ic_favoriteiconyellow"), for: .normal)
           }
           
       } catch {}
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storeid = countryList[indexPath.row].id
        let urunSayfasi = MarketSayfasi()
        urunSayfasi.itemid = "\(storeid)"
        urunSayfasi.modalPresentationStyle = .fullScreen
        present(urunSayfasi, animated: true, completion: nil)
    }
    
    
}
