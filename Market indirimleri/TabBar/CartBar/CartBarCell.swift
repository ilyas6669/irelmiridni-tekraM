//
//  CartBarCell.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 5/13/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import UIKit

class CartBarCell: UICollectionViewCell,UIGestureRecognizerDelegate {
    @IBOutlet weak var imgUrun: UIImageView!
    
    @IBOutlet weak var lblIsim: UILabel!
    
    
    @IBOutlet weak var lblFiyat: UILabel!
    
    @IBOutlet weak var lblIsim2: UILabel!
    
    @IBOutlet weak var lblTarih: UILabel!
    
    var pan: UIPanGestureRecognizer!
    var deleteLabel1: UIImageView!
    var deleteLabel2: UIImageView!
    
    
    @IBOutlet weak var likeImageViewWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imgLiked: UIImageView!
    

    lazy var likeAnimator = LikeAnimator(container: contentView, layoutConstraint: likeImageViewWidthConstraint)
     
     lazy var doubleTapRecognizer: UITapGestureRecognizer = {
         
         let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
         
         tapRecognizer.numberOfTapsRequired = 2
         tapRecognizer.delaysTouchesBegan = true
         
         return tapRecognizer
     }()
     
      var btnTapAction : (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commonInit()
         imgUrun.contentMode = .scaleAspectFit
        imgUrun.addGestureRecognizer(doubleTapRecognizer)
     
    }
    
     override func layoutSubviews() {
        super.layoutSubviews()

        if (pan.state == UIGestureRecognizer.State.changed) {
          let p: CGPoint = pan.translation(in: self)
          let width = self.contentView.frame.width
          let height = self.contentView.frame.height
          self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
//          self.deleteLabel1.frame = CGRect(x: p.x - deleteLabel1.frame.size.width-10, y: 0, width: 24, height: 24)
//          self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0, width: 24, height: 24)
            deleteLabel1.translatesAutoresizingMaskIntoConstraints = false
            deleteLabel2.translatesAutoresizingMaskIntoConstraints = false
            deleteLabel1.rightAnchor.constraint(equalTo: rightAnchor,constant: -5).isActive = true
            deleteLabel2.rightAnchor.constraint(equalTo: rightAnchor,constant: -5).isActive = true
            deleteLabel1.merkezYSuperView()
            deleteLabel2.merkezYSuperView()
            
            deleteLabel1.heightAnchor.constraint(equalToConstant: 32).isActive = true
            deleteLabel2.heightAnchor.constraint(equalToConstant: 32).isActive = true
            deleteLabel1.widthAnchor.constraint(equalToConstant: 32).isActive = true
            deleteLabel2.widthAnchor.constraint(equalToConstant: 32).isActive = true
        }

      }
    
    @objc func didDoubleTap() {
          btnTapAction?()
           
           likeAnimator.animate { [weak self] in
               
               
           }
           
       }
    

    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizer.State.began {

        } else if pan.state == UIGestureRecognizer.State.changed {
          self.setNeedsLayout()
        } else {
          if abs(pan.velocity(in: self).x) > 500 {
            let collectionView: UICollectionView = self.superview as! UICollectionView
            let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
            collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
          } else {
            UIView.animate(withDuration: 0.2, animations: {
              self.setNeedsLayout()
              self.layoutIfNeeded()
            })
          }
        }
      }
    
    
    
    private func commonInit() {
      self.contentView.backgroundColor = UIColor.white
      self.backgroundColor = UIColor.red

    

      deleteLabel1 = UIImageView(image: UIImage(named: "love-and-romance"))
       
      self.insertSubview(deleteLabel1, belowSubview: self.contentView)

      deleteLabel2 = UIImageView(image: UIImage(named: "love-and-romance"))
    
      self.insertSubview(deleteLabel2, belowSubview: self.contentView)

      pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
      pan.delegate = self
      self.addGestureRecognizer(pan)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
      return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
    }
    
    

}
