//
//  MarketSayfasi.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData

//ge burdaki temani sene basa salim demeli o yazdigin funtion var idiye istifade eliyirdih o lazm deyil iki dene tanimliyirix listden eyni sey olur prosta birinin adin search nen qoymusam basdiqinda ele bil ki axtaranda search icin axtarir axtarmayanda normal olaninin

class MarketSayfasi: UIViewController {
    
    
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
         //view.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
    var searchcountryList2 = [Resulttt]()
    var isSearching = false
    
    var marketlist = [Market]()
    
    private var lastContentOffset: CGFloat = 0.0
    
    let lblAciklama : UILabel = {
       let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .darkGray
        lbl.font = UIFont.systemFont(ofSize: 12)
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
        view.backgroundColor = .customWhite()
        searchBar.delegate = self
             
        veriCek()
        veriCekUrun()
        
       
       
        view.addSubview(topView)
        view.addSubview(ortaView)
        ortaView.addSubview(lblAciklama)
        ortaView.addSubview(searchBar)
        topView.addSubview(btnLeft)
        topView.addSubview(btnFavori)
        view.addSubview(imgUrun)
        view.addSubview(urunlerCollectionView)
        view.addSubview(viewBulunmadi)
        viewBulunmadi.addSubview(imgBulunmadi)
        viewBulunmadi.addSubview(lblBUlunmadi)
        searchBar.addSubview(activityIndicator)
        
        
        
        
        _ = topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = ortaView.anchor(top: imgUrun.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = lblAciklama.anchor(top: ortaView.topAnchor, bottom: nil, leading: ortaView.leadingAnchor, trailing: ortaView.trailingAnchor,padding: .init(top: 0, left: 5, bottom: 0, right: 5))
        _ = searchBar.anchor(top: lblAciklama.bottomAnchor, bottom: ortaView.bottomAnchor, leading: ortaView.leadingAnchor, trailing: ortaView.trailingAnchor)
        _ = viewBulunmadi.anchor(top: ortaView.bottomAnchor, bottom: view.bottomAnchor  , leading: view.leadingAnchor, trailing: view.trailingAnchor)
        imgBulunmadi.merkezKonumlamdirmaSuperView()
        imgBulunmadi.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50).isActive = true
        _ = lblBUlunmadi.anchor(top: imgBulunmadi.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = urunlerCollectionView.anchor(top: ortaView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        
        btnLeft.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnLeft.leftAnchor.constraint(equalTo: topView.leftAnchor,constant: 10).isActive = true
        btnFavori.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        btnFavori.rightAnchor.constraint(equalTo: topView.rightAnchor,constant: -10).isActive = true
        imgUrun.centerYAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        imgUrun.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        activityIndicator.rightAnchor.constraint(equalTo: searchBar.rightAnchor,constant: -35).isActive = true
        
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13, *)
        {
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = UIColor.customYellow()
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        }
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
        //bunu axtarisan? he burdada eyni koddu ordada prosta tabunu isletmirem burda neyi isdedsen be aaaaaaaa funcsion isletmirsende asagida elediyim kimi elirsen
       
        
        let jsonUrlString = "https://marketindirimleri.com/api/v1/products/?store=\(itemid)&q=\(searchkeyword)&format=json"
        
     
        guard let url = URL(string: jsonUrlString) else {return}
        
     
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
         
            
            
            do {
                
                var welcomee : Welcomee!
                
                welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self.countryList2 = welcomee.results
                    
                    if self.countryList2.count == 0 { //urun yoxdu
                        self.urunlerCollectionView.isHidden = true
                        self.viewBulunmadi.isHidden = false
                         self.activityIndicator.stopAnimating()
                    }else{
                        
                        self.urunlerCollectionView.isHidden = false
                        self.viewBulunmadi.isHidden = true
                         self.activityIndicator.stopAnimating()
                    }
                    
                    self.urunlerCollectionView.reloadData()
                   self.activityIndicator.stopAnimating()
                    
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
        
        if isSearching {
            return searchcountryList2.count
        }else{
            return countryList2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = urunlerCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
        if isSearching{
            cell.lblIsim.text = searchcountryList2[indexPath.row].name
            cell.lblFiyat.text = searchcountryList2[indexPath.row].price
            cell.imgUrun.sd_setImage(with: URL(string: "\(searchcountryList2[indexPath.row].image.imageDefault)"))
            //"2020-05-13"
            let isoDate = searchcountryList2[indexPath.row].validDates[1]
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
            
            let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(searchcountryList2[indexPath.row].storeID)?format=json"
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
                
                if tagstatus == 0 { //favori degil ise
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    
                    let favoriteproduct = NSEntityDescription.insertNewObject(forEntityName: "FavoriteProduct", into: context)
                    //bu urunlerin oldugu list hansidi ? sen duzgun ad veremmirsende buna country nedi ala :D
                    favoriteproduct.setValue("\(self.searchcountryList2[indexPath.row].id)", forKey: "id")
                    
                    cell.imgLiked.tag = 1
                    cell.imgLiked.isHidden = false
                    
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
                                
                                if id == "\(self.searchcountryList2[indexPath.row].id)" {
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
                    
                    
                }
                
                
            }
            
            
            
            
            return cell
            
            
            
            
        }else{
            
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
                
                if tagstatus == 0 { //favori degil ise
                    
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
                        
                        cell.imgLiked.tag = 0
                        cell.imgLiked.isHidden = true
                        
                        do {
                            try context.save()
                        } catch {
                            print("bir hata var")
                        }
                        
                    } catch {}
                    
                    
                }
                
                
            }
            
            
            
            
            return cell
            
        }
        
        
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
    //
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y < self.lastContentOffset) {
            
            imgUrun.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imgUrun.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
        }
        else if (scrollView.contentOffset.y > self.lastContentOffset) {
            
            
            imgUrun.heightAnchor.constraint(equalToConstant: 100).isActive = true
            imgUrun.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
        }
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    
}

extension MarketSayfasi : UISearchBarDelegate {
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" { //
            
            
            
            isSearching = false
            view.endEditing(true)
            urunlerCollectionView.reloadData()
        }
        else {
            
            isSearching = true
            searchcountryList2 = countryList2.filter({ value -> Bool in
                guard let text =  searchBar.text else { return false}
                return value.name.lowercased().contains(text.lowercased())
                
            })
            if searchcountryList2.count == 0 {
                urunlerCollectionView.isHidden = true
                viewBulunmadi.isHidden = false
            }else {
                urunlerCollectionView.isHidden = false
                viewBulunmadi.isHidden = true
            }
            urunlerCollectionView.reloadData()
        }
        
    }
    
}

