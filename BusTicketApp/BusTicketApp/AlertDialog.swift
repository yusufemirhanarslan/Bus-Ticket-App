//
//  AlertDialog.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 6.04.2023.
//

import Foundation
import UIKit


class AlertDialog {
 
    static func showAlert(alertTitle: String,
                          alertMessage: String,
                          defaultTitle: String,
                          cancelTitle: String,
                          viewController: UIViewController) {
        
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let defaultButton = UIAlertAction(title: defaultTitle, style: .default)
        let cancelButton = UIAlertAction(title: cancelTitle, style: .cancel)
        
        alert.addAction(defaultButton)
        alert.addAction(cancelButton)
        
        viewController.present(alert, animated: true,completion: nil)
        
    }
      
}
