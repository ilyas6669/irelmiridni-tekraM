//
//  SearchBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage

extension SearchBar : UIGestureRecognizerDelegate {

func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    if touch.view?.isDescendant(of: self.marketlerTableView) == true {
        return false
    } else if
        touch.view?.isDescendant(of: self.urunlerTableView) == true {
        return false
    } else {
        view.endEditing(true)
        return true
    }
}
}

class SearchBar: UIViewController{
    
    //MARK: Control
    var sortallcity = false
    var sortsetting = 0 // 0 = store | 1 = product
    
    var storeList = [Resultt]()
    var productList = [Resulttt]()
    
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
        lbl.text = "Mağaza Ara"
        return lbl
    }()
    
    
    
    let btnTopLeft : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "mapicon_dark"), for: .normal)
        btn.addTarget(self, action: #selector(btnTopLeftAction), for: .touchUpInside)
        return btn
    }()
    
    let btnTopSetting : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "ic_setting_black"), for: .normal)
        btn.addTarget(self, action: #selector(btnTopSettingAction), for: .touchUpInside)
        return btn
    }()
    
    let viewMagazaAra : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblMagazaAra : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Mağaza Ara"
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 30)
        return lbl
    }()
    
    let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    let marketlerTableView = UITableView()
    
    let urunlerTableView = UITableView()
    
    let aramaPop : AramaPop = {
        let arama = AramaPop()
        arama.translatesAutoresizingMaskIntoConstraints = false
        arama.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return arama
    }()
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pickerView = UIPickerView()
    
    let array = ["Mağaza ara","Ürün ara"]
    
    let viewSetting : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        return view
    }()
    
    let lblAramaModu : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.text = "Arama Modu"
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.translatesAutoresizingMaskIntoConstraints = false
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
    
    var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    let visualEffectView2 : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imgRight : UIImageView = {
        let img = UIImageView(image: UIImage(named: "ic_uparrow_right_long_white"))
        img.heightAnchor.constraint(equalToConstant: 300).isActive = true
        img.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return img
    }()
    
    let lblRight : UILabel = {
       let lbl = UILabel()
        lbl.text = "ARAMA TERCİHİ ŞANSI"
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 24)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let imgLeft : UIImageView = {
        let img = UIImageView(image: UIImage(named: "ic_uparrow_left_long_white"))
        img.heightAnchor.constraint(equalToConstant: 150).isActive = true
        img.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return img
    }()
    
    let lblLeft : UILabel = {
          let lbl = UILabel()
           lbl.text = "ŞEHİR TERCİHİ ŞANSI"
           lbl.textColor = .white
           lbl.textAlignment = .center
           lbl.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 24)
           lbl.translatesAutoresizingMaskIntoConstraints = false
           return lbl
       }()
    
    var tamamid = ""
    
    let btnTamam : UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .customYellow()
        btn.setTitle("TAMAM", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tamamBtnAction), for: .touchUpInside)
        return btn
    }()
    
    let btnImageLeft : UIImageView = {
       let img = UIImageView(image: UIImage(named: "mapicon_dark"))
        return img
    }()
    
    let btnImageRight : UIImageView = {
          let img = UIImageView(image: UIImage(named: "ic_setting_black"))
           return img
       }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
        
        
       
        //MARK: addSubview
        view.addSubview(viewTop)
        viewTop.addSubview(lblTop)
        viewTop.addSubview(btnTopLeft)
        viewTop.addSubview(btnTopSetting)
        view.addSubview(searchBar)
        view.addSubview(viewMagazaAra)
        viewMagazaAra.addSubview(lblMagazaAra)
        view.addSubview(marketlerTableView)
        view.addSubview(urunlerTableView)
        view.addSubview(viewSetting)
        viewSetting.addSubview(lblAramaModu)
        viewSetting.addSubview(pickerView)
        searchBar.addSubview(activityIndicator)
       

        
        
        //viewSetting.merkezKonumlamdirmaSuperView()
        _ = viewSetting.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        lblAramaModu.topAnchor.constraint(equalTo: viewSetting.topAnchor,constant: 10).isActive = true
        lblAramaModu.centerXAnchor.constraint(equalTo: viewSetting.centerXAnchor).isActive = true
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.merkezKonumlamdirmaSuperView()
        _ = pickerView.anchor(top: nil, bottom: nil, leading: viewSetting.leadingAnchor, trailing: viewSetting.trailingAnchor)
        
        viewSetting.isHidden = true
        
        //MARK: constraint
        _ = viewTop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        lblTop.merkezKonumlamdirmaSuperView()
        btnTopLeft.merkezYSuperView()
        btnTopLeft.leadingAnchor.constraint(equalTo: viewTop.leadingAnchor,constant: 5).isActive = true
        btnTopSetting.merkezYSuperView()
        btnTopSetting.trailingAnchor.constraint(equalTo: viewTop.trailingAnchor,constant: -5).isActive = true
        _ = searchBar.anchor(top: viewTop.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = viewMagazaAra.anchor(top: searchBar.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        lblMagazaAra.merkezKonumlamdirmaSuperView()
        _ = marketlerTableView.anchor(top: searchBar.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = urunlerTableView.anchor(top: searchBar.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        activityIndicator.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor).isActive = true
        activityIndicator.rightAnchor.constraint(equalTo: searchBar.rightAnchor,constant: -35).isActive = true
        
        
        
        marketlerTableView.isHidden = true
        urunlerTableView.isHidden = true
        
        
        marketlerTableView.delegate = self
        marketlerTableView.dataSource = self
        marketlerTableView.register(UINib(nibName: "MarketlerCel", bundle: nil), forCellReuseIdentifier: "MarketlerCel")
        marketlerTableView.refreshControl = refreshControl
        
        
        urunlerTableView.delegate = self
        urunlerTableView.dataSource = self
        urunlerTableView.register(UINib(nibName: "UrunlerTableViewCell", bundle: nil), forCellReuseIdentifier: "UrunlerTableViewCell")
        urunlerTableView.refreshControl = refreshControl
        
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
         gestureREcongizer.delegate = self
        view.addGestureRecognizer(gestureREcongizer)
       
        
        //        let gestureREcongizer2 = UITapGestureRecognizer(target: self, action: #selector(handleDismissal2))
        //        view.addGestureRecognizer(gestureREcongizer2)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        searchBar.delegate = self
        
        aramaPop.btnTamam.addTarget(self, action: #selector(btnTamamAction), for: .touchUpInside)
        
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchBardialog")
        fetchRequest.returnsObjectsAsFaults = false
        
        var selectedid = ""
        var datacontrol = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let id = result.value(forKey: "id") as? String {
                    selectedid = id
                    datacontrol = true
                }
            }
            
            if datacontrol{ ///kayit olub
                visualEffectView2.alpha = 0
                lblLeft.isHidden = true
                lblRight.isHidden = true
                imgRight.isHidden = true
                imgLeft.isHidden = true
                btnTamam.isHidden = true
                btnImageRight.isHidden = true
                btnImageLeft.isHidden = true
                //fsoo
                
                //bunu duzeldemmirsen ? yoxx bele eliye bildim bilmirem ele nece ellriler cox pis deyan
                
                
            }else{ ///kayit olmuyub
                
                view.addSubview(visualEffectView2)
                _ = visualEffectView2.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
                visualEffectView2.alpha = 0.8
                
                view.addSubview(imgRight)
                _ = imgRight.anchor(top: btnTopSetting.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 5))
                
                view.addSubview(lblRight)
                _ = lblRight.anchor(top: imgRight.bottomAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 5))
                
                view.addSubview(imgLeft)
                _ = imgLeft.anchor(top: btnTopLeft.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 10, bottom: 0, right: 0))
                
                view.addSubview(lblLeft)
                _ = lblLeft.anchor(top: imgLeft.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 0, right: 0))
                
                view.addSubview(btnTamam)
                _ = btnTamam.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 25, bottom: 10, right: 25))
                
                view.addSubview(btnImageLeft)
                _ = btnImageLeft.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 10, left: 5, bottom: 0, right: 0))
                
                view.addSubview(btnImageRight)
                _ = btnImageRight.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 5))
             
                
            }
            
        } catch {
            print("error")
        }
        
        
        
        
        //tanitim vieww
    
        
    }
    
    @objc func tamamBtnAction() {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "SearchBardialog", into: context)
        
        newPainting.setValue("1", forKey: "id")
        
        do {
            try context.save()
            print("Succes")
        } catch {
            print("error")
        }
      
        
        
        visualEffectView2.alpha = 0
        lblLeft.isHidden = true
        lblRight.isHidden = true
        imgRight.isHidden = true
        imgLeft.isHidden = true
        btnTamam.isHidden = true
        btnImageRight.isHidden = true
        btnImageLeft.isHidden = true
        
        
    }
    
    @objc private func refresh(sender:UIRefreshControl) {
        sender.endRefreshing()
        
    }
    
    
    
    @objc func btnTamamAction() {
        sortallcity = aramaPop.btnSwitch.isOn
        handleDismissal()
    }
    
    @objc func btnTopLeftAction() {
        view.addSubview(aramaPop)
        aramaPop.merkezKonumlamdirmaSuperView()
        _ = aramaPop.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        aramaPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        aramaPop.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.aramaPop.alpha = 1
            self.aramaPop.transform = CGAffineTransform.identity
        }
        
    }
    
    @objc func btnTopSettingAction() {
        viewSetting.isHidden = false
    }
    
    @objc func handleDismissal() {
        view.endEditing(true)
        viewSetting.isHidden = true
        UIView.animate(withDuration: 0.3, animations: {
            self.aramaPop.alpha = 0
            self.visualEffectView.alpha = 0
            self.aramaPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.aramaPop.removeFromSuperview()
        }
    }
    
    @objc func handleDismissal2() {
        viewSetting.isHidden = true
    }
    
    
    func getitem (searchkeyword: String){
        
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
            
            var url = ""
            
            switch sortsetting {
            case 0:
                url = "https://marketindirimleri.com/api/v1/stores/?format=json&q=\(searchkeyword)"
                break
            case 1:
                url = "https://marketindirimleri.com/api/v1/products/?format=json&q=\(searchkeyword)"
                break
            default:
                break
            }
            
            print("Nicatalibli:\(sortallcity)")
            
            if !sortallcity {
                url = "\(url)&city=\(selectid)"
            }
            
            guard let url2 = URL(string: url) else {return}
            
            
            URLSession.shared.dataTask(with: url2) { (data, response, error) in
                //perhaps check err
                guard let data = data else {return}
                
                do {
                    
                    var welcome : Welcome!
                    var welcomee : Welcomee!
                    
                    switch self.sortsetting{
                    case 0://store
                        welcome = try JSONDecoder().decode(Welcome.self, from: data)
                        break
                    case 1://product
                        welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                        break
                    default:
                        break
                    }
                    
                    DispatchQueue.main.async {
                        
                        switch self.sortsetting{
                        case 0: //store
                            
                            
                            self.storeList = welcome.results
                            
                            if !self.sortallcity {
                                
                                var swapList = [Resultt]()
                                
                                for storeitem in self.storeList {
                                    if storeitem.cities.contains(Int(selectid)!){
                                        swapList.append(storeitem)
                                    }
                                }
                                self.storeList = swapList
                         
                                self.marketlerTableView.reloadData()
                                self.activityIndicator.stopAnimating()
                                
                                self.marketlerTableView.isHidden = false
                                self.urunlerTableView.isHidden = true
                                
                            }else{
                                self.marketlerTableView.reloadData()
                                self.activityIndicator.stopAnimating()
                                
                                self.marketlerTableView.isHidden = false
                                self.urunlerTableView.isHidden = true
                            }
                            
                            
                         
                            break
                        case 1: //product
                            
                            
                            self.productList = welcomee.results
                            
                            self.urunlerTableView.reloadData()
                            self.activityIndicator.stopAnimating()
                           

                            
                            self.marketlerTableView.isHidden = true
                            self.urunlerTableView.isHidden = false
                            
                            break
                        default:
                            break
                        }
                        
                        
                    }
                    
                    
                    
                } catch let jsonError {
                    
                    
                }
                
                
            }.resume()
            
            
        } catch {  }
        
        
    }
    
    
    
    
}


extension SearchBar : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == marketlerTableView {
            return storeList.count
        }else {
            return productList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == marketlerTableView {
            let cell = marketlerTableView.dequeueReusableCell(withIdentifier: "MarketlerCel", for: indexPath) as! MarketlerCel
            cell.lblIsim.text = storeList[indexPath.row].name
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequestCity = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
            fetchRequestCity.returnsObjectsAsFaults = false
            
            var selectcounrty = ""
            var selectid = ""
            
            do {
                let results = try context.fetch(fetchRequestCity)
                
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
            cell.lblSehir.text = selectcounrty
            cell.imgUrun.sd_setImage(with: URL(string: "\(storeList[indexPath.row].image.imageDefault)"))
            
            
            ///--------------------------FAVORI BUTON CLICK----------------------------------------------------------------
            cell.btnTapAction = { //favori buton
                () in
                
                let tagstatus = cell.btnFavori.tag
                
                if tagstatus == 0 { //favori degil ise
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    
                    let favoriteproduct = NSEntityDescription.insertNewObject(forEntityName: "FavoriteStore", into: context)
                    favoriteproduct.setValue("\(self.storeList[indexPath.row].id)", forKey: "id")
                    
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
                                
                                if id == "\(self.storeList[indexPath.row].id)" {
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
                        
                        if id == "\(self.storeList[indexPath.row].id)" {
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
        } else {
            
            let cell1 = urunlerTableView.dequeueReusableCell(withIdentifier: "UrunlerTableViewCell", for: indexPath) as! UrunlerTableViewCell
            cell1.lblIsim.text = productList[indexPath.row].name
            cell1.lblFiyat.text = productList[indexPath.row].price
            cell1.imgUrun.sd_setImage(with: URL(string: "\(productList[indexPath.row].image.imageDefault)"))
            cell1.lblTarih.text = productList[indexPath.row].validDates[1]
            
            
            let jsonUrlString = "https://marketindirimleri.com/api/v1/stores/\(productList[indexPath.row].storeID)?format=json"
            let url = URL(string: jsonUrlString)
            
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                //perhaps check err
                guard let data = data else {return}
                
                do {
                    let welcomee = try JSONDecoder().decode(SingleStore.self, from: data)
                    
                    DispatchQueue.main.async {
                        cell1.lblUrunIsim.text = welcomee.name
                        
                        
                        
                    }
                    
                } catch let jsonError {print("Error serializing json:", jsonError)}
            }.resume()
            
            
            
            ///--------------------------FAVORI BUTON CLICK---------------------------------------------------------------
            
            cell1.btnTapAction = { //favori buton
                () in
                
                let tagstatus = cell1.btnFavori.tag
                
                if tagstatus == 0 { //favori degil ise
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context = appDelegate.persistentContainer.viewContext
                    
                    let favoriteproduct = NSEntityDescription.insertNewObject(forEntityName: "FavoriteProduct", into: context)
                    favoriteproduct.setValue("\(self.productList[indexPath.row].id)", forKey: "id")
                    
                    cell1.btnFavori.tag = 1
                    cell1.btnFavori.setImage(UIImage(named: "ic_favoriteiconyellowselected"), for: .normal)
                    
                    
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
                                
                                if id == "\(self.productList[indexPath.row].id)" {
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
                    
                    cell1.btnFavori.tag = 0
                    cell1.btnFavori.setImage(UIImage(named: "ic_favoriteiconyellow"), for: .normal)
                    
                }
                
            }
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
                        
                        if id == "\(self.productList[indexPath.row].id)" {
                            favoriteproductcontrol = true
                            break
                        }else{
                            favoriteproductcontrol = false
                        }
                        
                    }
                    
                }
                if favoriteproductcontrol{
                    cell1.btnFavori.tag = 1
                    cell1.btnFavori.setImage(UIImage(named: "ic_favoriteiconyellowselected"), for: .normal)
                }else{
                    cell1.btnFavori.tag = 0
                    cell1.btnFavori.setImage(UIImage(named: "ic_favoriteiconyellow"), for: .normal)
                }
                
                
            } catch {}
            
            
            
            
            return cell1
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == marketlerTableView {
            
            let storeid = storeList[indexPath.row].id
            
            let urunSayfasi = MarketSayfasi()
            urunSayfasi.itemid = "\(storeid)"
            urunSayfasi.modalPresentationStyle = .fullScreen
            present(urunSayfasi, animated: true, completion: nil)
            
        }else{
            
            let productid =  productList[indexPath.row].id
            
            let urunSayfasi = UrunSayfasi()
            urunSayfasi.itemid = "\(productid)"
            urunSayfasi.modalPresentationStyle = .fullScreen
            present(urunSayfasi, animated: true, completion: nil)
           
        }
    }
    
    
}

extension SearchBar : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewSetting.isHidden = true
        
        if array[row] == "Ürün ara"{
            lblTop.text = "Ürün Ara"
            lblMagazaAra.text = "Ürün Ara"
            sortsetting = 1
        }else{
            sortsetting = 0
            lblTop.text = "Mağaza Ara"
            lblMagazaAra.text = "Mağaza Ara"
        }
        
    }
    
    
    
    
    
    
}

extension SearchBar : UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        activityIndicator.startAnimating()
        
        getitem(searchkeyword: searchBar.text!)
    }
    
}


