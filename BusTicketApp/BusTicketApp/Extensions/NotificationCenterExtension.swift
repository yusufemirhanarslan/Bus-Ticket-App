//
//  NotificationCenterExtension.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 2.04.2023.
//

import Foundation

extension NSNotification.Name {
    
    static let maxSelected = Notification.Name(rawValue: "maxSelected")
    static let seatNumbers = Notification.Name(rawValue: "seatNumbers")
    static let nextButton = Notification.Name(rawValue: "nextButton")
    static let seatNumbersInController = Notification.Name(rawValue: "seatNumbersInController")
    static let emptySeat = Notification.Name(rawValue: "emptySeat")
}
