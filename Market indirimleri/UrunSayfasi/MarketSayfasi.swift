//
//  MarketSayfasi.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData


class MarketSayfasi: UIViewController {
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+1000)
    
    lazy var scrolView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .customWhite()
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.frame.size = contentViewSize
        return view
    }()
    
    let aciklamaView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.heightAnchor.constraint(equalToConstant: 250).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let altView : UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let topView : UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ortaView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let btnLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ic_back_dark"), for: .normal)
        btn.addTarget(self, action: #selector(btnLeftAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let btnFavori : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ic_favoriteicondark"), for: .normal)
        btn.addTarget(self, action: #selector(btnFavoriAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let imgUrun : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        img.translatesAutoresizingMaskIntoConstraints = false
        img.widthAnchor.constraint(equalToConstant: 90).isActive = true
        img.heightAnchor.constraint(equalToConstant: 90).isActive = true
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.layer.borderColor = UIColor.customYellow().cgColor
        img.layer.borderWidth = 2
        return img
    }()
    
    let lblAciklama : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.text = "Label Label Labe Label Label Label Label Label Label Label Label LabelLabel abel LabelLabel Label Label Label Ll Label Label Label Label Label Label Label Label Label Label"
        lbl.numberOfLines = 30
        lbl.translatesAutoresizingMaskIntoConstraints = false
        //lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let searchBar : UISearchBar = {
        let serach = UISearchBar()
        serach.backgroundColor = .white
        serach.placeholder = "Arama Yap"
        return serach
    }()
    
    
    fileprivate let urunlerCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .customWhite()
        return cv
    }()
    
    var itemid = ""
    
    var countryList2 = [Resulttt]()
    var marketlist = [Market]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       view.backgroundColor = .customYellow()
       
     
              
        
        veriCek()
        veriCekUrun()
        
       
        let ortaViewSV = UIStackView(arrangedSubviews: [lblAciklama,searchBar])
        ortaViewSV.axis = .vertical
        ortaViewSV.spacing = 0
        
        
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        view.addSubview(topView)
        containerView.addSubview(ortaView)
        ortaView.addSubview(ortaViewSV)
        topView.addSubview(btnLeft)
        topView.addSubview(btnFavori)
        view.addSubview(imgUrun)
        containerView.addSubview(urunlerCollectionView)
        
        
        _ = scrolView.anchor(top: topView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = ortaView.anchor(top: containerView.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        _ = ortaViewSV.anchor(top: topView.bottomAnchor, bottom: ortaView.bottomAnchor, leading: ortaView.leadingAnchor, trailing: ortaView.trailingAnchor)
        _ = lblAciklama.topAnchor.constraint(equalTo: imgUrun.bottomAnchor).isActive = true
        btnLeft.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: topView.leftAnchor,constant: 5).isActive = true
        btnFavori.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnFavori.rightAnchor.constraint(equalTo: topView.rightAnchor,constant: -5).isActive = true
        imgUrun.centerYAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        imgUrun.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        _ = urunlerCollectionView.anchor(top: ortaViewSV.bottomAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        
        urunlerCollectionView.delegate = self
        urunlerCollectionView.dataSource = self
        urunlerCollectionView.register(UINib(nibName: "FiyatCell", bundle: nil), forCellWithReuseIdentifier: "FiyatCell")
        urunlerCollectionView.register(AramaPop.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
        
        if let layout = urunlerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width, height: 310)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        
        
        
    }
    
    func veriCek() {
   
        let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(itemid)?format=json"
        guard let url = URL(string: jsonUrlString)
            else {
                print("NicatalibliError:\(itemid)")

                return
            
        }
        print("NicatalibliError:\(url)")

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //perhaps check err
            // ala bular duzduye mence men linki pojo eliyennen sora duzgun eliyemmisem altdakini
            guard let data = data else {return}
            
            do {
                //bu single market nedi goster bidene
                let welcomee = try JSONDecoder().decode(Market.self, from: data)
                
                DispatchQueue.main.async {
                    
//                    self.marketlist = welcomee
//                    print("Nicatalibli:\(welcomee.results)")
                    self.lblAciklama.text = welcomee.name
                    //self.imgUrun.sd_setImage(with: URL(string: "\(welcomee.image.imageDefault)"))
                    
                    //sen demisenki  avlar lave ala bisen nieee o terefden id gondermirdim axi ona gore ne ocur alinirdi ne bu cur onnan imishh keciremm bashka problemee//burdan verini alanda sen o birsini istidafe elemisen onda butun marketleri alanda istifade eliyiyr basa dusdummm 
                    
                }
                
                
                
                
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
        
    }
    
    
    func veriCekUrun() {
        //BU niyese cekmirrrrrr
        
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
                    
                    
                }
                
                
                
                
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
        
    }
    
    
    
    
    @objc func btnLeftAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func btnFavoriAction() {
        print("favori")
    }
    
    
    
    
    
}

extension MarketSayfasi : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryList2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = urunlerCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
        cell.lblIsim.text = countryList2[indexPath.row].name
        cell.lblFiyat.text = countryList2[indexPath.row].price
        cell.imgUrun.sd_setImage(with: URL(string: "\(countryList2[indexPath.row].image.imageDefault)"))
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
    
//    private func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath as IndexPath)
//        
//        headerView.frame.size.height = 100
//        
//        return headerView
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        
//        return CGSize(width: collectionView.frame.width, height: 100)
//    }
//    
    
    
}
