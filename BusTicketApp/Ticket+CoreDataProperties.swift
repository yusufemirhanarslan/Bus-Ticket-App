//
//  Ticket+CoreDataProperties.swift
//  
//
//  Created by Yusuf Emirhan Arslan on 10.04.2023.
//
//

import Foundation
import CoreData


extension Ticket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ticket> {
        return NSFetchRequest<Ticket>(entityName: "Ticket")
    }

    @NSManaged public var dateDay: Int16
    @NSManaged public var dateMonth: Int16
    @NSManaged public var dateYear: Int16
    @NSManaged public var fromLocation: String?
    @NSManaged public var hour: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var price: String?
    @NSManaged public var qrImage: Data?
    @NSManaged public var seatNumbers: NSObject?
    @NSManaged public var toLocation: String?
    @NSManaged public var passengers: Passenger?

}
