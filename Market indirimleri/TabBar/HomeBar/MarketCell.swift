//
//  MarketCell.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/25/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class MarketCell: UICollectionViewCell {

    @IBOutlet weak var imgUrun: UIImageView!
    
    
    @IBOutlet weak var lblIsim: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 5
        imgUrun.contentMode = .scaleAspectFill
    }

}
