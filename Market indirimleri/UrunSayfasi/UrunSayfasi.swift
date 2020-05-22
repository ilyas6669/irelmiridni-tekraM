//
//  UrunSayfasi.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData

class UrunSayfasi: UIViewController {
    
    var storeid = ""
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.heightAnchor.constraint(equalToConstant: 330).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let altView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imgUrun : UIImageView = {
        let img = UIImageView()
        //img.contentMode = .
        img.backgroundColor = .white
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
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.text = ""
        lbl.numberOfLines = 4
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let lblFiyat : UILabel = {
           let lbl = UILabel()
           lbl.textColor = .customYellow()
           lbl.textAlignment = .left
           lbl.text = ""
           lbl.numberOfLines = 2
           lbl.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 25)
           lbl.translatesAutoresizingMaskIntoConstraints = false
           return lbl
       }()
    
    let lblAciklama : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        lbl.text = ""
        lbl.numberOfLines = 30
        lbl.translatesAutoresizingMaskIntoConstraints = false
         lbl.font = UIFont.boldSystemFont(ofSize: 17)
        return lbl
    }()
    
    let lblTarih : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        lbl.text = ""
        lbl.numberOfLines = 2
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        return lbl
    }()
    
    let lblIsim2 : UILabel = {
        let lbl = UILabel()
           lbl.textColor = .darkGray
           lbl.textAlignment = .left
           lbl.text = ""
           lbl.numberOfLines = 2
           lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
           return lbl
       }()
    
    let offerText : UILabel = {
          let lbl = UILabel()
             lbl.textColor = .darkGray
             lbl.textAlignment = .left
             lbl.text = ""
             lbl.numberOfLines = 2
             lbl.translatesAutoresizingMaskIntoConstraints = false
          lbl.font = UIFont.boldSystemFont(ofSize: 17)
             return lbl
         }()
    
    var itemid = ""
    
  
     var countryList2 = [Resulttt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        veriCekUrun()
       
  
        
        let lblSV = UIStackView(arrangedSubviews: [lblIsim,lblFiyat,lblAciklama,lblTarih,lblIsim2,offerText])
        lblSV.axis = .vertical
        lblSV.spacing = 0
        
        view.addSubview(ustView)
        ustView.addSubview(imgUrun)
        ustView.addSubview(btnLeft)
        ustView.addSubview(btnFavori)
        view.addSubview(altView)
        altView.addSubview(lblSV)
        
        
        _ = ustView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = imgUrun.anchor(top: ustView.topAnchor, bottom: ustView.bottomAnchor, leading: ustView.leadingAnchor, trailing: ustView.trailingAnchor)
        _ = btnLeft.anchor(top: ustView.topAnchor, bottom: nil, leading: ustView.leadingAnchor, trailing: nil,padding: .init(top: 45, left: 10, bottom: 0, right: 0))
         _ = btnFavori.anchor(top: ustView.topAnchor, bottom: nil, leading: nil, trailing: ustView.trailingAnchor,padding: .init(top: 45, left: 0, bottom: 0, right: 10))
        _ = altView.anchor(top: ustView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = lblSV.anchor(top: ustView.bottomAnchor, bottom: nil, leading: altView.leadingAnchor, trailing: altView.trailingAnchor,padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwpie(sender:)))

        downSwipe.direction = .up
        view.addGestureRecognizer(downSwipe)
        
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
                      
                      if id == "\(itemid)" {
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
    
   
    @objc func handleSwpie(sender:UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .up:
                
                if storeid != ""{

                    let alturunsayfasi = AltUrunSayfasi()
                    alturunsayfasi.iditem = itemid
                    alturunsayfasi.idstore = storeid
                    alturunsayfasi.modalPresentationStyle = .fullScreen
                    present(alturunsayfasi, animated: true, completion: nil)

                    
                }
                
            default: break
                
            }
        }
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
            favoriteproduct.setValue("\(itemid)", forKey: "id")
            
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
            btnFavori.setImage(UIImage(named: "ic_favoriteiconyellow"), for: .normal)
            
        }
        
        
        
    }
    
    
    func veriCekUrun() {
              
               
              let jsonUrlString = "https://marketindirimleri.com/api/v1/products/\(itemid)?format=json"
              guard let url = URL(string: jsonUrlString) else {return}
              
              URLSession.shared.dataTask(with: url) { (data, response, error) in
                  //perhaps check err
                  guard let data = data else {return}
                  
                  do {
                                  
                      let welcomee = try JSONDecoder().decode(SingleProduct.self, from: data)

                      print("Nicatalibli:\(welcomee.image.imageDefault)")
                      print("Nicatalibli:\(URL(string: "\(welcomee.image.imageDefault)"))")

                    
                      DispatchQueue.main.async {
                        
                        self.lblIsim.text = welcomee.name
                        self.lblFiyat.text = welcomee.price
                        self.lblAciklama.text = welcomee.detail
                        self.lblTarih.text = "Geçerlilik Tarihi: \(welcomee.validDates[0]) - \(welcomee.validDates[1])"
                        self.imgUrun.sd_setImage(with: URL(string: "\(welcomee.image.imageDefault)"))
                        self.storeid = "\(welcomee.storeID)"
                        self.lblIsim2Deyis(storeid: "\(welcomee.storeID)")
                        self.offerText.text = welcomee.offerText
                        
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
                            self.lblIsim2.text = welcomee.name
                               
                           }
                           
                       } catch let jsonError {print("Error serializing json:", jsonError)}
                       
                       
                   }.resume()
    }
   
    
    
}
