//
//  AltUrunSayfasi.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/4/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData

class AltUrunSayfasi: UIViewController {
    
    var countryList2 = [Resulttt]()
    var idArray = [Int]()
    
    var iditem = ""
    var idstore = ""
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ustImage : UIImageView = {
        let img = UIImageView(image: UIImage(named: ""))
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let btnLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ic_back_yellow"), for: .normal)
        btn.addTarget(self, action: #selector(btnLeftAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnFavori : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ic_favoriteiconyellow"), for: .normal)
        btn.addTarget(self, action: #selector(btnFavoriAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let lblIsim : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .customYellow()
        lbl.textAlignment = .center
        lbl.text = "Label Label Label Label  "
        lbl.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 19)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 3
        return lbl
    }()
    
    fileprivate let urunlerCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .customWhite()
        return cv
    }()
    
    let viewDigerUrunler : UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view
    }()
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblDigerUrunler : UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.font = UIFont.systemFont(ofSize: 22)
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutDuzenle()
        duzenleCollectionView()
        veriCekUrun()
        verileriCek()
        
     
        
    }
    
    func layoutDuzenle(){
        
        view.backgroundColor = .customYellow()
        
        view.addSubview(ustView)
        view.addSubview(viewDigerUrunler)
        viewDigerUrunler.addSubview(lblDigerUrunler)
        ustView.addSubview(ustImage)
        ustView.addSubview(visualEffectView)
        ustView.addSubview(btnLeft)
        ustView.addSubview(btnFavori)
        ustView.addSubview(lblIsim)
        view.addSubview(urunlerCollectionView)
        
        
        _ = ustView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = viewDigerUrunler.anchor(top: ustView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        lblDigerUrunler.merkezXSuperView()
        lblDigerUrunler.leadingAnchor.constraint(equalTo: viewDigerUrunler.leadingAnchor,constant: 5).isActive = true
        
        ustImage.leftAnchor.constraint(equalTo: ustView.leftAnchor).isActive = true
        ustImage.bottomAnchor.constraint(equalTo: ustView.bottomAnchor).isActive = true
        ustImage.rightAnchor.constraint(equalTo: ustView.rightAnchor).isActive = true
        ustImage.topAnchor.constraint(equalTo: ustView.topAnchor).isActive = true
        visualEffectView.leftAnchor.constraint(equalTo: ustView.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: ustView.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: ustView.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: ustView.topAnchor).isActive = true
        visualEffectView.alpha = 0.5
        btnLeft.merkezYSuperView()
        btnLeft.leftAnchor.constraint(equalTo: ustView.leftAnchor,constant: 10).isActive = true
        btnLeft.topAnchor.constraint(equalTo: ustView.topAnchor,constant: 15).isActive = true
        btnFavori.merkezYSuperView()
        btnFavori.rightAnchor.constraint(equalTo: ustView.rightAnchor,constant: -10).isActive = true
        btnFavori.topAnchor.constraint(equalTo: ustView.topAnchor,constant: 15).isActive = true
        lblIsim.merkezKonumlamdirmaSuperView()
        lblIsim.topAnchor.constraint(equalTo: view.topAnchor,constant: 15).isActive = true
        lblIsim.leadingAnchor.constraint(equalTo: btnLeft.trailingAnchor).isActive = true
        lblIsim.trailingAnchor.constraint(equalTo: btnFavori.leadingAnchor).isActive = true
        lblIsim.bottomAnchor.constraint(equalTo: ustView.bottomAnchor).isActive = true
        _ = urunlerCollectionView.anchor(top: viewDigerUrunler.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        
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
                             
                             if id == "\(iditem)" {
                                 favoriteproductcontrol = true
                                 break
                             }else{
                                 favoriteproductcontrol = false
                             }
                             
                         }
                         
                     }
                     if favoriteproductcontrol{
                         btnFavori.tag = 1
                         btnFavori.setImage(UIImage(named: "ic_favoriteiconyellowselected"), for: .normal)
                     }else{
                         btnFavori.tag = 0
                         btnFavori.setImage(UIImage(named: "ic_favoriteiconyellow"), for: .normal)
                     }
                     
                     //fsyo baxmm
                 } catch {}
        
    }
    
    
    
    
    func duzenleCollectionView() {
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
    
    func veriCekUrun() {
    let jsonUrlString = "https://marketindirimleri.com/api/v1/products/\(iditem)?format=json"
                    guard let url = URL(string: jsonUrlString) else {return}
                    
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        //perhaps check err
                        guard let data = data else {return}
                        
                        do {
                                        
                            let welcomee = try JSONDecoder().decode(SingleProduct.self, from: data)
                         
                            DispatchQueue.main.async {
                              
                              self.lblIsim.text = welcomee.name
                              
                            
                              self.ustImage.sd_setImage(with: URL(string: "\(welcomee.image.imageDefault)"))
                             
                                self.lblIsim2Deyis(storeid: "\(welcomee.storeID)")
                                
                            }
                            
                                   
                            
                        } catch let jsonError {
                            print("Error serializing json:", jsonError)
                            
                            
                        }
                        
                        
                    }.resume()
        
    }
    
    func lblIsim2Deyis(storeid : String) {
          
           let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(storeid)?format=json"
                      let url = URL(string: jsonUrlString)
                      
                      URLSession.shared.dataTask(with: url!) { (data, response, error) in
                          //perhaps check err
                          guard let data = data else {return}
                          
                          do {
                              let welcomee = try JSONDecoder().decode(SingleStore.self, from: data)
                              
                              DispatchQueue.main.async {
                               self.lblDigerUrunler.text = "\(welcomee.name)diğer ürünler" 
                              }
                              
                          } catch let jsonError {print("Error serializing json:", jsonError)}
                          
                          
                      }.resume()
       }
    
    
    func verileriCek() {
      
       
        let jsonUrlString = "https://marketindirimleri.com/api/v1/products/?store=\(idstore)&format=json"
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
                   
                   
                }
                
                
                //bulardaki apiden gelen verilerdi
                        
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
        
    }
    
    @objc func btnLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnFavoriAction() {
         let tagstatus = btnFavori.tag
              
              if tagstatus == 0 { //favori degil ise
                  
                  let appDelegate = UIApplication.shared.delegate as! AppDelegate
                  let context = appDelegate.persistentContainer.viewContext
                  
                  let favoriteproduct = NSEntityDescription.insertNewObject(forEntityName: "FavoriteProduct", into: context)
                  //urunun id si nedi adi
                  favoriteproduct.setValue("\(iditem)", forKey: "id")
                  
                  btnFavori.tag = 1
                  btnFavori.setImage(UIImage(named: "ic_favoriteiconyellowselected"), for: .normal)
                  
                  
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
                              
                              if id == "\(iditem)" {
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
                  btnFavori.setImage(UIImage(named: "ic_favoriteiconyellow"), for: .normal)
                  
              }
              
    }
    
    
    
}


extension AltUrunSayfasi : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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
