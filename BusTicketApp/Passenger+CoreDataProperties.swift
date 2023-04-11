//
//  Passenger+CoreDataProperties.swift
//  
//
//  Created by Yusuf Emirhan Arslan on 10.04.2023.
//
//

import Foundation
import CoreData


extension Passenger {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Passenger> {
        return NSFetchRequest<Passenger>(entityName: "Passenger")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var surname: String?
    @NSManaged public var tickets: NSSet?

}

// MARK: Generated accessors for tickets
extension Passenger {

    @objc(addTicketsObject:)
    @NSManaged public func addToTickets(_ value: Ticket)

    @objc(removeTicketsObject:)
    @NSManaged public func removeFromTickets(_ value: Ticket)

    @objc(addTickets:)
    @NSManaged public func addToTickets(_ values: NSSet)

    @objc(removeTickets:)
    @NSManaged public func removeFromTickets(_ values: NSSet)

}
