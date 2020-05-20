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
    
    
    @IBOutlet weak var lblTarih: UILabel!
    
    @IBOutlet weak var imgLiked: UIImageView!
    
    @IBOutlet weak var likeImageViewWidthConstraint: NSLayoutConstraint!

    
   lazy var likeAnimator = LikeAnimator(container: contentView, layoutConstraint: likeImageViewWidthConstraint)
    
    lazy var doubleTapRecognizer: UITapGestureRecognizer = {
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
    
        tapRecognizer.numberOfTapsRequired = 2
        tapRecognizer.numberOfTouchesRequired = 1
        
        return tapRecognizer
    }()
    
 
     var btnTapAction : (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgUrun.contentMode = .scaleAspectFit
        imgUrun.addGestureRecognizer(doubleTapRecognizer)
        
        
       
        
        
    }
    
    @objc func didDoubleTap() {
       btnTapAction?()
        
        likeAnimator.animate { [weak self] in
            
            
        }
        
    }
    
   
}
