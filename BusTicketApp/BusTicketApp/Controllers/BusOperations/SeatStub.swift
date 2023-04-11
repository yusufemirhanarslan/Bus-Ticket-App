//
//  SeatStub.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 6.04.2023.
//

import Foundation

struct SeatStub {
    var id: Int
    var number: Int
    var salable: Bool
    var gender: Bool
    var hall: Bool
}

class MockSeatCreater {

    func create(count: Int) -> [SeatStub] {
            var list = [SeatStub]()
            var seatNumber = 1
            var totalSpace = 0
            while seatNumber-totalSpace != count+1 {
                var isHall = (seatNumber - 2) % 5 == 1
                if (seatNumber - totalSpace + 5) > count {
                    isHall = false
                }
                if isHall {
                    totalSpace += 1
                }
                let stub = SeatStub(id: seatNumber - 1,
                                    number: seatNumber - totalSpace,
                                    salable: true,
                                    gender: false,
                                    hall: isHall)
                list.append(stub)
                seatNumber += 1
            }
            return list
        }
    
}
