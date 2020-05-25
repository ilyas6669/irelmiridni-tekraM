//
//  MarketPage.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/25/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class MarketPage: UIViewController {
    
    var itemid = ""
    
    var countryList2 = [Resulttt]()
    
    var searchcountryList2 = [Resulttt]()
    
    var isSearching = false
    
    var marketlist = [Market]()
    
    @IBOutlet weak var lblAciklama: UILabel!
    
    @IBOutlet weak var urunlerCollectionView: UICollectionView!
    
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    
    private var lastContentOffset: CGFloat = 0.0
    
     var oldContentOffset = CGPoint.zero
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let constentOffset = scrollView.contentOffset.y - oldContentOffset.y
           
           if scrollView.contentOffset.y > 0 && constentOffset > 0 {
               if topViewTopConstraint.constant > -100 {
                   topViewTopConstraint.constant -= constentOffset
                   scrollView.contentOffset.y -= constentOffset
                   
               }
           }
           if scrollView.contentOffset.y < 0 && constentOffset < 0 {
               if topViewTopConstraint.constant < 0 {
                   if topViewTopConstraint.constant - constentOffset > 0 {
                       topViewTopConstraint.constant = 0
                   }else {
                       topViewTopConstraint.constant -= constentOffset
                   }
                   scrollView.contentOffset.y -= constentOffset
               }
           }
           oldContentOffset = scrollView.contentOffset
           
           
       }
    
    
    
}

extension MarketPage : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = urunlerCollectionView.dequeueReusableCell(withReuseIdentifier: "FiyatCell", for: indexPath) as! FiyatCell
        return cell
    }
    
    
    
    
    
}
