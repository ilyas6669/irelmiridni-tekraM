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
    
    var countryList = [Resultt]()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
        layoutDuzenle()
        duzenleCollectionView()
        
        
    }
    
    func layoutDuzenle() {
        
        //MARK: addSubview
        view.addSubview(viewTop)
        viewTop.addSubview(lblTop)
        view.addSubview(btnTopLeft)
        view.addSubview(marketlerTableView)
        
        //MARK: constraint
        _ = viewTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        lblTop.merkezKonumlamdirmaSuperView()
        
        btnTopLeft.centerYAnchor.constraint(equalTo: viewTop.centerYAnchor).isActive = true
        btnTopLeft.leftAnchor.constraint(equalTo: viewTop.leftAnchor,constant: 10).isActive = true
        
        _ = marketlerTableView.anchor(top: viewTop.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        
        
    }
    
    func duzenleCollectionView() {
        marketlerTableView.delegate = self
        marketlerTableView.dataSource = self
        marketlerTableView.register(UINib(nibName: "MarketlerCel", bundle: nil), forCellReuseIdentifier: "MarketlerCel")
        
    }
    
    func veriCekMarket() {
           
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let context = appDelegate.persistentContainer.viewContext
           
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
           fetchRequest.returnsObjectsAsFaults = false
           
           do {
                let results = try context.fetch(fetchRequest)
               
               for result in results as! [NSManagedObject] {
                   if let id = result.value(forKey: "id") as? Int {
                       self.idArray.append(id)
                      
                      
                      
                   }
               }
               
               
           } catch {
               print("error")
           }
          
           
           let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/?city=\(idArray.last!)"
                  guard let url = URL(string: jsonUrlString) else {return}
                 
                 URLSession.shared.dataTask(with: url) { (data, response, error) in
                     //perhaps check err
                     guard let data = data else {return}
                     
                   
                     do {

                         let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                         self.countryList = welcome.results
                       
                      
                       
                      
                       //reload datani verini tam aldigin yerde ele
                           //bulardaki apiden gelen verilerdi
                        
                                         
                         
                     } catch let jsonError {
                         print("Error serializing json:", jsonError)
                         
                         
                     }
                     
                     
                 }.resume()
            self.marketlerTableView.reloadData()
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
        return cell
    }
    
    
}
