//
//  HomeBar.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/24/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class HomeBar: UIViewController {
    
    
    //MARK: scrollView
   
    
    lazy var scrolView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
       
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = true
        view.bounces = true
        return view
    }()
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite()
       
        return view
    }()
    
    //MARK: properties
    
    let ustView : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
   let ortaView1 : UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 160).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
     view.backgroundColor = .green
        return view
    }()
    
    let ortaView2 : UIView = {
           let view = UIView()
           view.heightAnchor.constraint(equalToConstant: 120).isActive = true
           view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
           return view
       }()
    
    let altView : UIView = {
              let view = UIView()
              //view.heightAnchor.constraint(equalToConstant: 120).isActive = true
              view.translatesAutoresizingMaskIntoConstraints = false
           view.backgroundColor = .yellow
              return view
          }()
    
    
    
    
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
        lbl.text = "marketindirimleri"
        return lbl
    }()
    
    let btnTopSearch : UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "search-1"), for: .normal)
        btn.addTarget(self, action: #selector(btnTopLeftAction), for: .touchUpInside)
        return btn
    }()
    
    let imgReklam : UIImageView = {
        let img = UIImageView(image: #imageLiteral(resourceName: "reklam"))
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .customWhite()
        scrolView.resizeScrollViewContentSize()
//        scrolView.updateContentView()
        callFunction()
        
        
//        let contentRect: CGRect = scrolView.subviews.reduce(into: .zero) { rect, view in
//            rect = rect.union(view.frame)
//        }
//        scrolView.contentSize = contentRect.size
       
      
     
        
    }
    
    func callFunction() {
        
        collectionViewDuzenle()
        layoutDuzenle()
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
            layout.itemSize = CGSize(width: view.frame.width, height: 299)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
        
    }
    
    func layoutDuzenle() {
        
        let viewSV = UIStackView(arrangedSubviews: [ustView,ortaView1,ortaView2])
        viewSV.axis = .vertical
        
        //MARK: addSubview
        view.addSubview(scrolView)
        scrolView.addSubview(ustView)
       
        
        
        
        
        
//        containerView.addSubview(viewTop)
//        viewTop.addSubview(lblTop)
//        viewTop.addSubview(btnTopSearch)
//        containerView.addSubview(imgReklam)
//        containerView.addSubview(lblMarket)
//        containerView.addSubview(marketCollectionView)
//        containerView.addSubview(lblFiyat)
//        containerView.addSubview(fiyatlarCollectionView)
        //altView.addSubview(fiyatlarCollectionView)
        
        //MARK: constraint
        
        
        _ = ustView.anchor(top: scrolView.topAnchor, bottom: scrolView.bottomAnchor, leading: scrolView.leadingAnchor, trailing: scrolView.trailingAnchor)
         //_ = ortaView1.anchor(top: nil, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        //_ = ortaView2.anchor(top: nil, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        //_ = altView.anchor(top: nil, bottom: containerView.bottomAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
        
        
        
        
        
//        _ = viewTop.anchor(top: containerView.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
//
//        lblTop.merkezKonumlamdirmaSuperView()
//        btnTopSearch.merkezYSuperView()
//        btnTopSearch.leadingAnchor.constraint(equalTo: viewTop.leadingAnchor,constant: 5).isActive = true
//
//        _ = imgReklam.anchor(top: viewTop.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
//        _ = lblMarket.anchor(top: imgReklam.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 0, right: 0))
//        _ = marketCollectionView.anchor(top: lblMarket.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 0))
//        _ = lblFiyat.anchor(top: marketCollectionView.bottomAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: nil,padding: .init(top: 5, left: 5, bottom: 0, right: 0))
        //_ = fiyatlarCollectionView.anchor(top: altView.topAnchor, bottom: containerView.bottomAnchor, leading: altView.leadingAnchor, trailing: altView.trailingAnchor)
        
    }
    
    
    
    @objc func btnTopLeftAction() {
        
    }
    
    
}


extension HomeBar : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.marketCollectionView {
            return 20
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.marketCollectionView {
            let cell1 = marketCollectionView.dequeueReusableCell(withReuseIdentifier: "MarketCell", for: indexPath) as! MarketCell
            return cell1
        }else {
            let cell2 = fiyatlarCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
            return cell2
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
