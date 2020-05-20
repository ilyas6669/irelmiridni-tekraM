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
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+10000)
       
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
           view.backgroundColor = .customWhite()
           view.frame.size = contentViewSize
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
        img.widthAnchor.constraint(equalToConstant: 100).isActive = true
        img.heightAnchor.constraint(equalToConstant: 100).isActive = true
        img.clipsToBounds = true
        img.layer.cornerRadius = 10
        img.layer.borderColor = UIColor.customYellow().cgColor
        img.layer.borderWidth = 2
        return img
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
    
    private var lastContentOffset: CGFloat = 0.0
    
    let lblAciklama : UILabel = {
       let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 100
        return lbl
    }()
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
       view.backgroundColor = .customWhite()
        searchBar.delegate = self
             
        veriCek()
        veriCekUrun()
        
       
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        containerView.addSubview(topView)
        containerView.addSubview(lblAciklama)
        containerView.addSubview(searchBar)
        topView.addSubview(btnLeft)
        topView.addSubview(btnFavori)
        view.addSubview(imgUrun)
        containerView.addSubview(urunlerCollectionView)
        containerView.addSubview(viewBulunmadi)
        viewBulunmadi.addSubview(imgBulunmadi)
        viewBulunmadi.addSubview(lblBUlunmadi)
        
        
        
        _ = topView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        _ = lblAciklama.anchor(top: imgUrun.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        _ = searchBar.anchor(top: lblAciklama.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = viewBulunmadi.anchor(top: searchBar.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        imgBulunmadi.merkezKonumlamdirmaSuperView()
        imgBulunmadi.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50).isActive = true
        _ = lblBUlunmadi.anchor(top: imgBulunmadi.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = urunlerCollectionView.anchor(top: searchBar.bottomAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        
        btnLeft.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: topView.leftAnchor,constant: 10).isActive = true
        btnFavori.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnFavori.rightAnchor.constraint(equalTo: topView.rightAnchor,constant: -10).isActive = true
        imgUrun.centerYAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        imgUrun.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        viewBulunmadi.isHidden = true
        
        
        
        urunlerCollectionView.delegate = self
        urunlerCollectionView.dataSource = self
        urunlerCollectionView.register(UINib(nibName: "FiyatCell", bundle: nil), forCellWithReuseIdentifier: "FiyatCell")
        
       
//        urunlerCollectionView.register(UINib(nibName: "HeaderVieww", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderVieww")
        
        
        
        if let layout = urunlerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width, height: 334)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
        ///--------------------------FAVORI CONTROL----------------------------------------------------------------
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteStore")
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
                btnFavori.setImage(UIImage(named: "ic_favoriteicondarkselected"), for: .normal)
            }else{
                btnFavori.tag = 0
                btnFavori.setImage(UIImage(named: "ic_favoriteicondark"), for: .normal)
            }
            
            
            
        } catch {}
        
        
        
    }
    
    func veriCek() {
        
        let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(itemid)?format=json"
        guard let url = URL(string: jsonUrlString) else {return}
      

        URLSession.shared.dataTask(with: url) { (data, response, error) in
          
            guard let data = data else {return}
            
            do {
                
                let welcomee = try JSONDecoder().decode(Market.self, from: data)
                
                DispatchQueue.main.async {
                    

                    self.lblAciklama.text = welcomee.detail
                    self.imgUrun.sd_setImage(with: URL(string: "\(welcomee.image.imageDefault)"))
                   
                }
                
               
            } catch let jsonError {
                print("Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
        
    }
    
    
    func veriCekUrun() {
       
       
        let jsonUrlString = "https://marketindirimleri.com/api/v1/products/?store=\(itemid)&format=json"
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
            
            do {
                
                let welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self.countryList2 = welcomee.results
                    
                    if self.countryList2.count == 0 {

                        //MARK: urun yoxdu
                        self.viewBulunmadi.isHidden = false
                        self.urunlerCollectionView.isHidden = true
                        print("Nicatalibli:URUNYOK")
                    }else{
                        //urun var
                        self.viewBulunmadi.isHidden = true
                        self.urunlerCollectionView.isHidden = false
                    }
                    
                    self.countryList2.shuffle()
                    self.urunlerCollectionView.reloadData()
                    
                    
                }
                
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
        
    }
    
    
    func getitem (searchkeyword: String) {
        
        
        var url = ""
        
        //MARK: PROBLEM2 : yetm burda axtarisda dediyin linki qoyuram axtarir hecne tapmir bu searcdeki linki qoyuram tapir
        // "https://marketindirimleri.com/api/v1/products/?store=\(storeid)&q=\(query)&format=json";
        
        url = "https://marketindirimleri.com/api/v1/products/?store=\(itemid)&q=\(searchkeyword)&format=json"
        
        //bu bilgiler yazilan yere padding verde yetim haeasina ne harsina verm paddingi burda magazanin detaylari yazilibe girib ic ice deyilki sol terefine bax yaxciii versen indi ? yo hele
        

        
        guard let url2 = URL(string: url) else {return}
        
        print("Nicatalibli:\(url2)")
        
        URLSession.shared.dataTask(with: url2) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
            
            do {
                
                
                var welcomee : Welcomee!
                
                
                
                welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                
                DispatchQueue.main.async {
                    
                    
                    
                    
                    print("Nicatalibli:\(welcomee.results)")
                    
                    self.countryList2 = welcomee.results
                    
                    self.urunlerCollectionView.reloadData()
                    
                    
                    
                }
                
                
                
            } catch let jsonError {
                print("Nicatalibli:Error serializing json:", jsonError)
                
                
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
            
            let favoriteproduct = NSEntityDescription.insertNewObject(forEntityName: "FavoriteStore", into: context)
            //urunun id si nedi adi
            favoriteproduct.setValue("\(itemid)", forKey: "id")
            
            btnFavori.tag = 1
            btnFavori.setImage(UIImage(named: "ic_favoriteicondarkselected"), for: .normal)
            
            
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
            btnFavori.setImage(UIImage(named: "ic_favoriteicondark"), for: .normal)
            
        }
        
        
        

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
    
   
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderVieww", for: indexPath) as! HeaderVieww
//        return header
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return .init(width: view.frame.width, height: 57)
//    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < self.lastContentOffset) {
           
            imgUrun.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imgUrun.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
        }
        else if (scrollView.contentOffset.y > self.lastContentOffset) {
           
            
            imgUrun.heightAnchor.constraint(equalToConstant: 80).isActive = true
            imgUrun.widthAnchor.constraint(equalToConstant: 80).isActive = true
            
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    
}

extension MarketSayfasi : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getitem(searchkeyword: searchBar.text!)
        searchBar.resignFirstResponder()
    }
    
    

}
