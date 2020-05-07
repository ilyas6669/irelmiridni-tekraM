//
//  SearchBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import PopupDialog
import CoreData
import SDWebImage

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
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return view
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
        viewSetting.addSubview(pickerView)
        viewSetting.merkezKonumlamdirmaSuperView()
        _ = viewSetting.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.merkezKonumlamdirmaSuperView()
        
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
        
        marketlerTableView.isHidden = true
        urunlerTableView.isHidden = true
        
        
        
        marketlerTableView.delegate = self
        marketlerTableView.dataSource = self
        marketlerTableView.register(UINib(nibName: "MarketlerCel", bundle: nil), forCellReuseIdentifier: "MarketlerCel")
        
        
        
        urunlerTableView.delegate = self
        urunlerTableView.dataSource = self
         urunlerTableView.register(UINib(nibName: "UrunlerTableViewCell", bundle: nil), forCellReuseIdentifier: "UrunlerTableViewCell")
        
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
        let gestureREcongizer = UITapGestureRecognizer(target: self, action: #selector(handleDismissal))
        view.addGestureRecognizer(gestureREcongizer)
        
        let gestureREcongizer2 = UITapGestureRecognizer(target: self, action: #selector(handleDismissal2))
        view.addGestureRecognizer(gestureREcongizer2)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        searchBar.delegate = self
        
        
        aramaPop.btnTamam.addTarget(self, action: #selector(btnTamamAction), for: .touchUpInside)
        
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
            
            if !sortallcity {
                url = "\(url)&city=\(selectid)"
            }
            
            guard let url2 = URL(string: url) else {return}
            
            print("Nicatalibli:\(url2)")
            
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
                            
                            print("Nicatalibli:\(welcome.results)")
                            
                            self.storeList = welcome.results
                            
                            self.marketlerTableView.reloadData()
                            
                            self.marketlerTableView.isHidden = false
                            self.urunlerTableView.isHidden = true
                            
                            break
                        case 1: //product
                            
                            print("Nicatalibli:\(welcomee.results)")
                            
                            self.productList = welcomee.results
                            
                            self.urunlerTableView.reloadData()

                            self.marketlerTableView.isHidden = true
                            self.urunlerTableView.isHidden = false

                            break
                        default:
                            break
                        }
                    
                        
                    }
                    
                    
                    
                } catch let jsonError {
                    print("Nicatalibli:Error serializing json:", jsonError)
                    
                    
                }
                
                
            }.resume()
            
            
        } catch { print("Nicatalibli:error") }
        
        
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
            cell.lblSehir.text = selectcounrty
             cell.imgUrun.sd_setImage(with: URL(string: "\(storeList[indexPath.row].image.imageDefault)"))
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
                
           
            
            return cell1
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
            sortsetting = 1
        }else{
            sortsetting = 0
            lblTop.text = "Mağaza Ara"
        }
    }
    
    
}

extension SearchBar : UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getitem(searchkeyword: searchBar.text!)
    }
    
}
