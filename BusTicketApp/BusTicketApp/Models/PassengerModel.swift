//
//  PassengerModel.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 2.04.2023.
//

import Foundation
import UIKit

struct PassengerModel {
    
    var name: String
    var surname: String
    var email: String
    var password: String
    var id: UUID
    
    init(name: String  = "", surname: String = "" , email: String = "", password: String = "", id: UUID = UUID()) {
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
        self.id = id
    }
    
}
