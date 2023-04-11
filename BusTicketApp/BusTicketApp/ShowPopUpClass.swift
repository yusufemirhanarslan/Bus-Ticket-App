//
//  ShowPopUpClass.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 7.04.2023.
//

import Foundation
import UIKit

class ShowPopUpClass {
    
    static func showPopUp( description: String, animationName: String, sender: UIViewController) {
        
        
        let popUp = PopUpModel(description: description, animationName: animationName)
        let overLayer = OverLayerPopUp()
        
        overLayer.popupModel = popUp
        overLayer.appear(sender: sender)
        
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { timer in
            overLayer.hide()
        
        }
        
        
    }
    
    
}
