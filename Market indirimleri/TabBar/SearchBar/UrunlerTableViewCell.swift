//
//  UrunlerTableViewCell.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/7/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class UrunlerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imgUrun: UIImageView!
    
    @IBOutlet weak var lblIsim: UILabel!
    
  
    @IBOutlet weak var lblFiyat: UILabel!
    
    
    @IBOutlet weak var btnFavori: UIButton!
    
    @IBOutlet weak var lblUrunIsim: UILabel!
    
    @IBOutlet weak var lblTarih: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    
}
