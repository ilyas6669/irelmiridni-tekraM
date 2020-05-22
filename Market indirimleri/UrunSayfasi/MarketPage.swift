//
//  MarketPage.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/22/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class MarketPage: UIViewController {
    
    let topView : UIView = {
          let view = UIView()
          view.backgroundColor = .customYellow()
          view.heightAnchor.constraint(equalToConstant: 100).isActive = true
          view.translatesAutoresizingMaskIntoConstraints = false
          return view
      }()
    
   
      lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+1000)
          
          lazy var scrolView: UIScrollView = {
              let view = UIScrollView(frame: .zero)
              view.backgroundColor = .blue
              view.frame = self.view.bounds
              view.contentSize = contentViewSize
              view.autoresizingMask = .flexibleHeight
              view.showsHorizontalScrollIndicator = true
              view.bounces = true
            view.translatesAutoresizingMaskIntoConstraints = false
              return view
          }()
          
          lazy var containerView : UIView = {
              let view = UIView()
              view.backgroundColor = .blue
              view.frame.size = contentViewSize
            view.translatesAutoresizingMaskIntoConstraints = false
              return view
          }()
     
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customWhite()
        
        view.addSubview(topView)
        view.addSubview(scrolView)
        scrolView.addSubview(containerView)
        containerView.addSubview(searchBar)
    
       
        
        
        
        _ = topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        scrolView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        scrolView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrolView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrolView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        containerView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
//               containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//               containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//               containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        _ = searchBar.anchor(top: containerView.topAnchor, bottom: nil, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor)
        
     
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
