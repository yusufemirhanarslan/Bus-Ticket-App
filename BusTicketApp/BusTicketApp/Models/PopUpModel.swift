//
//  PopUpModel.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 7.04.2023.
//

import Foundation


struct PopUpModel {
    
    let description: String
    let animationName: String
    
    init(description: String = "", animationName: String = "") {
        self.description = description
        self.animationName = animationName
    }
    
}
