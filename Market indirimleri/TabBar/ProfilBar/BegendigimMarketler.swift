//
//  BegendigimMarketler.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

class BegendigimMarketler: UIViewController {
    
    var countryList = [SingleStore]()
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
        lbl.text = "Beğendiğim Mağazalar"
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
    
    var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
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
        
        //searchbara yazilan soz query di yaxciii opurrr o seyide eliyey ? ana seyfede nece gul qaldi ne???
        //demirdin revizede ana seyfede urunde nece gul qaldigi yazir he hee birde deirdine faovriye nese atanda haraxa deyisirrr
        //oo 2 defe basmag idi  ahaha onun tempi var yetm internet cox pids idpsipisdi sizdendi beeeke bilmirem gir ana seyfeni collectionviewsina 
        // "https://marketindirimleri.com/api/v1/products/?store=\(storeid)&q=\(query)&format=json";
      
    }
    
    func duzenleCollectionView() {
        marketlerTableView.delegate = self
        marketlerTableView.dataSource = self
        marketlerTableView.register(UINib(nibName: "MarketlerCel", bundle: nil), forCellReuseIdentifier: "MarketlerCel")
        
    }
    
    
    func veriCekMarket(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteStore")
        fetchRequest.returnsObjectsAsFaults = false
        
        countryList.removeAll(keepingCapacity: false)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let id = result.value(forKey: "id") as? String {
                    
                    print("Nicatalibli:\(id)")
                    //bu niye isdemir duz seyfedi baxmmm he he men yuxari basiridm
                    
                    let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(id)?format=json"
                    guard let url = URL(string: jsonUrlString) else {return}
                    
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        //perhaps check err
                        guard let data = data else {return}
                        
                        do {
                            
                            let singlestore = try JSONDecoder().decode(SingleStore.self, from: data)
                            
                            DispatchQueue.main.async {
                                
                                
                                self.countryList.append(singlestore)
                                self.countryList.reverse()
                                self.marketlerTableView.reloadData()
                                self.activityIndicator.stopAnimating()
                                
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
    
    
    
    
    
    
    @objc func btnTopLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}


extension BegendigimMarketler : UITableViewDataSource,UITableViewDelegate {
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storeid = countryList[indexPath.row]
        let urunSayfasi = MarketSayfasi()
        urunSayfasi.itemid = "\(storeid)"
        urunSayfasi.modalPresentationStyle = .fullScreen
        present(urunSayfasi, animated: true, completion: nil)
    }
    
   
}
