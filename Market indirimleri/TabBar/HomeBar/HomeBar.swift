//
//  HomeBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage



class HomeBar: UIViewController {
    //MARK: scrollView
    var countryList = [Resultt]()
    var idArray = [Int]()
    
    var countryList2 = [Resulttt]()
    
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
        view.backgroundColor = .rgb(red: 0, green: 38, blue: 26)
        view.frame.size = contentViewSize
        return view
    }()
    
    //MARK: properties
    
    let ustView : UIView = {
        let view = UIView()
        view.backgroundColor = .customYellow()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    let ortaView1 : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 160).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let ortaView2 : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 145).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customWhite()
        return view
    }()
    
    let altView : UIView = {
        let view = UIView()
        //view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customWhite()
        return view
    }()
    
    
    let lblTop : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "AvenirNextCondensed-BoldItalic", size: 24)
        lbl.text = "marketindirimleri"
        return lbl
    }()
    
    let btnTopSearch : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "search-1"), for: .normal)
        btn.addTarget(self, action: #selector(btnSearchAction), for: .touchUpInside)
        return btn
    }()
    
    let imgReklam : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "reklam"))
        img.contentMode = .scaleAspectFill
        img.heightAnchor.constraint(equalToConstant: 160).isActive = true
        return img
    }()
    
    let lblMarket : UILabel = {
        let lbl = UILabel()
        lbl.text = "İstanbul'da mağazalar"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        return lbl
    }()
    
    fileprivate let marketCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.heightAnchor.constraint(equalToConstant: 120).isActive = true
        cv.backgroundColor = .customWhite()
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let lblFiyat : UILabel = {
        let lbl = UILabel()
        lbl.text = "İstanbul'da son fiyatlar"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        return lbl
    }()
    
    fileprivate let fiyatlarCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .customWhite()
        return cv
    }()
    
    var activityIndicator : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var activityIndicator2 : UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.style = .large
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var refreshControl : UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customYellow()
        callFunction()
        
       
        
        
    }
    
    
   
    
    func callFunction() {
        
        layoutDuzenle()
        collectionViewDuzenle()
        veriCekMarket()
        veriCekUrun()
        activityIndicator.startAnimating()
        activityIndicator2.startAnimating()
        refreshControlAction()
        
    }
    
    func refreshControlAction() {
        
        scrolView.alwaysBounceVertical = true
        scrolView.bounces = true
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.scrolView.addSubview(refreshControl)
           
       }
    
    @objc func didPullToRefresh() {
        print("resfresh")
        
        refreshControl.endRefreshing()
        
    }
    
    func layoutDuzenle() {
        
        
        
        //MARK: addSubview
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        containerView.addSubview(ustView)
        ustView.addSubview(lblTop)
        ustView.addSubview(btnTopSearch)
        containerView.addSubview(ortaView1)
        ortaView1.addSubview(imgReklam)
        containerView.addSubview(ortaView2)
        ortaView2.addSubview(lblMarket)
        ortaView2.addSubview(marketCollectionView)
        containerView.addSubview(altView)
        altView.addSubview(lblFiyat)
        altView.addSubview(fiyatlarCollectionView)
        fiyatlarCollectionView.addSubview(activityIndicator)
        marketCollectionView.addSubview(activityIndicator2)
        
        
        //MARK: constraint
        
        _ = ustView.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        lblTop.merkezKonumlamdirmaSuperView()
        btnTopSearch.merkezYSuperView()
        btnTopSearch.leadingAnchor.constraint(equalTo: ustView.leadingAnchor,constant: 5).isActive = true
        _ = ortaView1.anchor(top: ustView.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        //_ = imgReklam.anchor(top: ustView.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        _ = ortaView2.anchor(top: ortaView1.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        _ = lblMarket.anchor(top: ortaView2.topAnchor, bottom: nil, leading: ortaView2.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 0, right: 0))
        _ = marketCollectionView.anchor(top: lblMarket.bottomAnchor, bottom: ortaView2.bottomAnchor, leading: ortaView2.leadingAnchor, trailing: ortaView2.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        _ = altView.anchor(top: ortaView2.bottomAnchor, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        _ = lblFiyat.anchor(top: ortaView2.bottomAnchor, bottom: nil, leading: altView.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 0, right: 0))
        _ = fiyatlarCollectionView.anchor(top: lblFiyat.bottomAnchor, bottom: containerView.bottomAnchor, leading: altView.leadingAnchor, trailing: altView.trailingAnchor)
        
        
        activityIndicator.centerXAnchor.constraint(equalTo: fiyatlarCollectionView.centerXAnchor).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: fiyatlarCollectionView.topAnchor,constant: 100).isActive = true
        
        activityIndicator2.centerXAnchor.constraint(equalTo: marketCollectionView.centerXAnchor).isActive = true
        activityIndicator2.topAnchor.constraint(equalTo: marketCollectionView.topAnchor,constant: 50).isActive = true
        
    }
    
    func collectionViewDuzenle() {
        marketCollectionView.delegate = self
        marketCollectionView.dataSource = self
        marketCollectionView.register(UINib(nibName: "MarketCell", bundle: nil), forCellWithReuseIdentifier: "MarketCell")
        
      
        
        fiyatlarCollectionView.delegate = self
        fiyatlarCollectionView.dataSource = self
        fiyatlarCollectionView.register(UINib(nibName: "FiyatCell", bundle: nil), forCellWithReuseIdentifier: "FiyatCell")
        
       
       
        
        
        if let layout = marketCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        
        
        if let layout = fiyatlarCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: view.frame.width, height: 310)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
        
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
                self.activityIndicator2.stopAnimating()
                
                
                
                
                print("666\(self.countryList[0].name)")
                print("666\(self.countryList[0].id)")
                print("666\(self.countryList[0].image)")
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
            }
        }.resume()
        self.marketCollectionView.reloadData()
        
    }
    
    func veriCekUrun() {
        let jsonUrlString = "https://marketindirimleri.com/api/v1/products/?city=\(idArray.last!)"
        print("Nicatalibli:\(jsonUrlString)")
        print("Nicataliblii:\(idArray.last!)")
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //perhaps check err
            guard let data = data else {return}
            
            
            
            
            
            
            do {
                
                
                
                let welcomee = try JSONDecoder().decode(Welcomee.self, from: data)
                
                DispatchQueue.main.async {
                    
                    self.countryList2 = welcomee.results
                    self.fiyatlarCollectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                    
                    
                }
                
                //bulardaki apiden gelen verilerdi
                
                
                
                
            } catch let jsonError {
                print("Error serializing json:", jsonError)
                
                
            }
            
            
        }.resume()
        
        
        
        
        
    }
    
    
    
    @objc func btnSearchAction() {
        tabBarController?.selectedIndex = 1
    }
    
    
    
    
}


extension HomeBar : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.marketCollectionView {
            return countryList.count
        }
        return countryList2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.marketCollectionView {
            let cell1 = marketCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketCell", for: indexPath) as! MarketCell
            cell1.lblIsim.text = countryList[indexPath.row].name
            cell1.imgUrun.sd_setImage(with: URL(string: "\(countryList[indexPath.row].image.imageDefault)"))
            return cell1
            
            
        }else {
            let cell2 = fiyatlarCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
            cell2.lblIsim.text = countryList2[indexPath.row].name
            cell2.lblFiyat.text = countryList2[indexPath.row].price
            cell2.imgUrun.sd_setImage(with: URL(string: "\(countryList2[indexPath.row].image.imageDefault)"))
            return cell2
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.marketCollectionView {
            
            
        }else{
            
        }
        
        
    }
    
    
    
}

extension UIScrollView {
    
    func resizeScrollViewContentSize() {
        
        var contentRect = CGRect.zero
        
        for view in self.subviews {
            
            contentRect = contentRect.union(view.frame)
            
        }
        
        self.contentSize = contentRect.size
        
    }
    
}
