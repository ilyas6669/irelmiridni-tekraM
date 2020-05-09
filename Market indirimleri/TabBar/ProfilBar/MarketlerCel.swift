//
//  MarketlerCel.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/26/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class MarketlerCel: UITableViewCell {
    
    @IBOutlet weak var imgUrun: UIImageView!
    
    @IBOutlet weak var lblIsim: UILabel!
    
    @IBOutlet weak var lblSehir: UILabel!
    
    
    @IBOutlet weak var btnFavori: UIButton!
    
      var btnTapAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgUrun.contentMode = .scaleAspectFill
        imgUrun.layer.borderWidth = 1
        imgUrun.layer.borderColor = UIColor.customWhite().cgColor
        
        btnFavori.addTarget(self, action: #selector(btnFavoriAction), for: .touchUpInside)
    }

    @objc func btnFavoriAction() {
          btnTapAction?()
    }
    
    
    
}
