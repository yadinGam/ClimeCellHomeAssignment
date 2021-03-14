//
//  Extensions.swift
//  ClimeCellHomeAssignment
//
//  Created by yadin g on 21/11/2020.
//

import Foundation
import UIKit

protocol Alertable {
      func presentAlert(title: String?, message: String, buttonTitle: String?)
}

extension String {
    func trimWhitespaces() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

extension Alertable where Self: UIViewController {
     func presentAlert(title: String? = nil, message: String, buttonTitle: String? = "OK") {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default) {  (action) in }
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
}

extension Date {
   static func getDayOfTheWeek(_ today : String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    guard let todayDate = formatter.date(from: today) else {
        return nil
    }
    
    return formatter.weekdaySymbols[Calendar.current.component(.weekday, from: todayDate) - 1]
    }
    
    func requestUrlFormattedDate() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return formatter.string(from: self)
    }
    
}
