//
//  Alert.swift
//  Market indirimleri
//
//  Created by İlyas Abiyev on 4/23/20.
//  Copyright © 2020 İlyas Abiyev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func makeAlert(tittle: String, message : String) {
            let alert = UIAlertController(title: tittle, message: message, preferredStyle: UIAlertController.Style.alert)
            let okButton =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    func datesRange(from: Date, to: Date) -> [Date] {
                 // in case of the "from" date is more than "to" date,
                 // it should returns an empty array:
                 if from > to { return [Date]() }
                 
                 var tempDate = from
                 var array = [tempDate]
                 
                 while tempDate < to {
                     tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
                     array.append(tempDate)
                 }
                 
                 return array
             }
}
