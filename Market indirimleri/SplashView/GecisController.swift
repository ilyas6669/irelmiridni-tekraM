//
//  GecisController.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class GecisController : UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    
    let goruntuler = ["walkthrough1","walkthrough2","walkthrough3"]
    let basliklar = ["Merheba!","Tüketimi azaltip dogayi korumaya var misin?","Ayni zamanda ek gelir elde etmeye ne dersin?"]
    
    let btnAtla : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("BACK", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .clear
         //btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //btn.widthAnchor.constraint(equalToConstant: 112).isActive = true
        btn.addTarget(self, action: #selector(btnAtlaClicked), for: .touchUpInside)
        return btn
    }()
    
    let btnSonraki : UIButton = {
              let btn = UIButton(type: .system)
              btn.setTitle("NEXT", for: .normal)
              btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .clear
            
              //btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
               //btn.widthAnchor.constraint(equalToConstant: 112).isActive = true
           btn.addTarget(self, action: #selector(btnSonrakiClicked), for: .touchUpInside)
              return btn
          }()
    
    let btnHadiBaslayim : UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("SELECT CITY", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .clear
        //btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //btn.widthAnchor.constraint(equalToConstant: 112).isActive = true
        btn.addTarget(self, action: #selector(hadibaslayalimAction), for: .touchUpInside)
        return btn
        
    }()
    
    let pageController : UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = UIColor.customYellow2()
        pc.pageIndicatorTintColor = UIColor.white
        return pc
    
    }()
    
    let selectCityPop : SelectCityPop = {
       let view = SelectCityPop()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        pageController.currentPage = Int(x / view.frame.width)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //collectionView.backgroundColor = .green
        
       
        
        view.addSubview(btnAtla)
        view.addSubview(btnSonraki)
        view.addSubview(pageController)
        view.addSubview(btnHadiBaslayim)
        
        
        
        collectionView.register(WelcomeSayfa.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = true
        
       
              
        _ = pageController.anchor(top: nil, bottom: btnAtla.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        _ = btnSonraki.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 20))
        _ = btnAtla.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: nil,padding: .init(top: 0, left: 20, bottom: 10, right: 0))
        
        _ = btnHadiBaslayim.anchor(top: nil, bottom: view.bottomAnchor, leading: nil, trailing: view.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 20))
        
        
        
        
        
        btnAtla.isHidden = true
        btnHadiBaslayim.isHidden = true
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goruntuler.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WelcomeSayfa
        cell.image1.image = UIImage(named: goruntuler[indexPath.row])
        cell.lbl1.text = basliklar[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc func btnSonrakiClicked() {
        pageController.currentPage += 1
        let indexpath = IndexPath(item: pageController.currentPage, section: 0)
        collectionView.scrollToItem(at: indexpath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        print("\(pageController.currentPage)")
        if pageController.currentPage == 1  {
            btnAtla.isHidden = false
        } else if pageController.currentPage == 2 {
            btnSonraki.isHidden = true
            btnHadiBaslayim.isHidden = false
        }
        
       
        
         

       }
       
    
    @objc func btnAtlaClicked() {
        print("back")
        
    }
    
    
    @objc func hadibaslayalimAction() {
        view.addSubview(selectCityPop)
        _ = selectCityPop.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,padding: .init(top: 40, left: 20, bottom: 40, right: 20))
        selectCityPop.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        selectCityPop.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.selectCityPop.alpha = 1
            self.selectCityPop.transform = CGAffineTransform.identity
        }
    }
    
    
}

