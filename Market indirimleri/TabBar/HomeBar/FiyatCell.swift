//
//  FiyatCell.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/25/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class FiyatCell: UICollectionViewCell {

    @IBOutlet weak var imgUrun: UIImageView!
    
    @IBOutlet weak var lblIsim: UILabel!
    
    @IBOutlet weak var lblFiyat: UILabel!
    
    @IBOutlet weak var lblIsim2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgUrun.contentMode = .scaleAspectFill
    }

}
