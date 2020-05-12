//
//  ProfilBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData

class ProfilBar: UIViewController {
    
    var countryList = [Resultt]()
    var idArray = [String]()
    
    var countryList2 = [Resulttt]()
    var countryList3 = [SingleProduct]()
    
    
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
        lbl.text = "Profilim"
        return lbl
    }()
    
    let ustView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customYellow()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
        return view
    }()
    
    let btnSehir : UIButton = {
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 29)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(btnSehirSecAction), for: .touchUpInside)
        return btn
    }()
    
    let selectCityPop : SelectCityPop = {
        let view = SelectCityPop()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let altView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customYellow2()
        return view
    }()
    
    let btnMarket : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("0 Market", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(btnMarketAction), for: .touchUpInside)
        return btn
    }()
    
    let btnUrun : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .clear
        btn.setTitle("0 Ürün", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(btnUrunAction), for: .touchUpInside)
        return btn
    }()
    
    let altView2 : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customWhite()
        return view
    }()
    
    let btnBegendigimMarket : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        
        btn.setTitle("Beğendiğim Marketler", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.addTarget(self, action: #selector(btnBegeniMarketAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return btn
    }()
    
    let btnBegendigimUrun : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .white
        
        btn.setTitle("Beğendiğim Ürünler", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.addTarget(self, action: #selector(btnBegendigimUrunAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return btn
    }()
    
    let imgBegendigimMarket : UIImageView = {
        let img = UIImageView(image: UIImage(named: "favoriteProducts"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let imgBegendigimUrun : UIImageView = {
        let img = UIImageView(image: UIImage(named: "favorite-grey"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let lblBegendigimMarket : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.text = "0"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblBegendigimUrun : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.text = "0"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customYellow()
        layoutDuzenle()
        veriCekUrun()
        veriCekMarket()
        lblBegendigimUrunDeyis()
        
    }
    
    func layoutDuzenle() {
        
       
        
        //MARK: stackView
        let btnSV = UIStackView(arrangedSubviews: [btnMarket,btnUrun])
        btnSV.axis = .horizontal
        btnSV.distribution = .fillEqually
        
        let btn2SV = UIStackView(arrangedSubviews: [btnBegendigimMarket,btnBegendigimUrun])
        btn2SV.axis = .vertical
        btn2SV.distribution = .fillEqually
        btn2SV.spacing = 15
        
        //MARK: addSubview
        view.addSubview(viewTop)
        viewTop.addSubview(lblTop)
        view.addSubview(ustView)
        ustView.addSubview(btnSehir)
        view.addSubview(altView)
        altView.addSubview(btnSV)
        view.addSubview(altView2)
        altView2.addSubview(btn2SV)
        btnBegendigimMarket.addSubview(imgBegendigimMarket)
        btnBegendigimMarket.addSubview(lblBegendigimMarket)
        btnBegendigimUrun.addSubview(imgBegendigimUrun)
        btnBegendigimUrun.addSubview(lblBegendigimUrun)
        
        //MARK: constraint
        _ = viewTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        lblTop.merkezKonumlamdirmaSuperView()
        
        _ = ustView.anchor(top: viewTop.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        btnSehir.merkezKonumlamdirmaSuperView()
        
        _ = altView.anchor(top: ustView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        _ = btnSV.anchor(top: altView.topAnchor, bottom: altView.bottomAnchor, leading: altView.leadingAnchor, trailing: altView.trailingAnchor)
        
        _ = altView2.anchor(top: altView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        _ = btn2SV.anchor(top: altView.bottomAnchor, bottom: nil, leading: altView2.leadingAnchor, trailing: altView2.trailingAnchor,padding: .init(top: 20, left: 10, bottom: 0, right: 10))
        
        imgBegendigimMarket.centerYAnchor.constraint(equalTo: btnBegendigimMarket.centerYAnchor).isActive = true
        imgBegendigimMarket.leftAnchor.constraint(equalTo: btnBegendigimMarket.leftAnchor,constant: 10).isActive = true
        
        lblBegendigimMarket.centerYAnchor.constraint(equalTo: btnBegendigimMarket.centerYAnchor).isActive = true
        lblBegendigimMarket.rightAnchor.constraint(equalTo: btnBegendigimMarket.rightAnchor,constant: -12).isActive = true
        
        imgBegendigimUrun.centerYAnchor.constraint(equalTo: btnBegendigimUrun.centerYAnchor).isActive = true
        imgBegendigimUrun.leftAnchor.constraint(equalTo: btnBegendigimUrun.leftAnchor,constant: 10).isActive = true
        
        lblBegendigimUrun.centerYAnchor.constraint(equalTo: btnBegendigimUrun.centerYAnchor).isActive = true
        lblBegendigimUrun.rightAnchor.constraint(equalTo: btnBegendigimUrun.rightAnchor,constant: -12).isActive = true
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        //tap.delegate = self
        view.addGestureRecognizer(tap)
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
        
    }
    
    
    func veriCekMarket() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        fetchRequest.returnsObjectsAsFaults = false
       
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let id = result.value(forKey: "id") as? String {
                    self.idArray.append(id)
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
                    
                    self.btnMarket.setTitle("\(self.countryList.count) Market", for: .normal)
                   
                   
                    
                }
                
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
            }
        }.resume()
        
        
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
        
        let jsonUrlString = "https://marketindirimleri.com/api/v1/products/?city=\(selectid)&format=json"
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
            
            do {
                
                let welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                
                DispatchQueue.main.async {
                    
                  self.countryList2 = welcomee.results
                    self.btnUrun.setTitle("\(welcomee.count) Ürün", for: .normal)
                    self.btnSehir.setTitle("\(selectcounrty)", for: .normal)
                    
                }
                
            
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
        
        
    }
    
    
    func lblBegendigimUrunDeyis() {
              let appDelegate = UIApplication.shared.delegate as! AppDelegate
              let context = appDelegate.persistentContainer.viewContext
              let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteProduct")
              fetchRequest.returnsObjectsAsFaults = false
              
              countryList3.removeAll(keepingCapacity: false)
              
              do {
                  let results = try context.fetch(fetchRequest)
                  
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
                                            
                                          self.countryList3.append(singleproduct)
                                          self.countryList3.reverse()
                                            self.lblBegendigimUrun.text = "\(self.countryList3.count)"
                                          
                                            
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
    
    
    @objc func btnSehirSecAction() {
        view.addSubview(selectCityPop)
        self.selectCityPop.sehirTableView.separatorColor = .white
        _ = selectCityPop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 40, left: 20, bottom: 40, right: 20))
        selectCityPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        selectCityPop.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.selectCityPop.alpha = 1
            self.selectCityPop.transform = CGAffineTransform.identity
        }
        
    }
    
    @objc func handleDismissal() {
           view.endEditing(true)
           UIView.animate(withDuration: 0.3, animations: {
               self.selectCityPop.alpha = 0
               self.visualEffectView.alpha = 0
               self.selectCityPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
           }) { (_) in
               self.selectCityPop.removeFromSuperview()
           }
       }
    

    
    @objc func btnMarketAction() {
        let marketler = Marketler()
        marketler.modalPresentationStyle = .fullScreen
        self.present(marketler, animated: true, completion: nil)
    }
    
    @objc func btnUrunAction() {
        let urunler = Urunler()
        urunler.modalPresentationStyle = .fullScreen
        self.present(urunler, animated: true, completion: nil)
        
    }
    @objc func btnBegeniMarketAction() {
        let begendigimMarketler = BegendigimMarketler()
        begendigimMarketler.modalPresentationStyle = .fullScreen
        self.present(begendigimMarketler, animated: true, completion: nil)
    }
    
    @objc func btnBegendigimUrunAction() {
        self.tabBarController?.selectedIndex = 2
    }
    
    
    
}


