//
//  MoveModel.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 6.04.2023.
//

import Foundation

struct MoveModel {
    
    var fromLocation: String
    var toLocation: String
    var dateDay: Int
    var dateMonth: Int
    var dateYear: Int
    
    init(fromLocation: String = "", toLocation: String = "" , dateDay: Int = 31 , dateMonth: Int = 12 , dateYear: Int = 1970) {
        self.fromLocation = fromLocation
        self.toLocation = toLocation
        self.dateDay = dateDay
        self.dateMonth = dateMonth
        self.dateYear = dateYear
    }
    
}
