//
//  HeaderVieww.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/12/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class HeaderVieww: UICollectionReusableView {
   
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .customWhite()
        
       
    }
    
}

