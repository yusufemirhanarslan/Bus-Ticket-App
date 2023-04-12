//
//  SeatDataManager.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 6.04.2023.
//

import Foundation
import ALBusSeatView

class SeatDataManager {
    var seatList = [[SeatStub]]()
    var selectedSeatlist = [SeatStub]()
    var section = 0
    var item = 0
    var type: Bool = false
    var seatNumber = [Int]()
}


extension SeatDataManager: ALBusSeatViewDelegate {
    
    func seatView(_ seatView: ALBusSeatView,didSelectAtIndex indexPath: IndexPath,seatType: ALBusSeatType, selectionType: ALSelectionType) {
        
        let seatCount = selectedSeatlist.count
        
        if seatCount + 1  > 5 {
            
            NotificationCenter.default.post(name: .maxSelected, object: nil)
            
        }else {
            
            var stub = seatList[indexPath.section][indexPath.item]
            stub.gender = selectionType == .man ? true : false
            selectedSeatlist.append(stub)
            
            section = indexPath.section
            item = indexPath.item
            type = stub.gender
            seatNumber.append(stub.number)
            
            seatView.reload()
            NotificationCenter.default.post(name: .seatNumbers, object: nil)
            
        }
       
    }
    
    func seatView(_ seatView: ALBusSeatView, deSelectAtIndex indexPath: IndexPath, seatType: ALBusSeatType) {
        
        let stub = seatList[indexPath.section][indexPath.item]
        selectedSeatlist.removeAll(where: { $0.id == stub.id })
        seatView.reload()
        
        let stub2 = seatList[indexPath.section][indexPath.item]
        seatNumber.removeAll(where: {$0 == stub2.number})
        
        NotificationCenter.default.post(name: .seatNumbers, object: nil)
    }
}

extension SeatDataManager:  ALBusSeatViewDataSource  {
    
    func seatView(_ seatView: ALBusSeatView,
                  seatNumberForIndex indexPath: IndexPath) -> String {
        
        let stub = seatList[indexPath.section][indexPath.item]
        return "\(stub.number)"
    }
    
    func seatView(_ seatView: ALBusSeatView,
                  seatTypeForIndex indexPath: IndexPath) -> ALBusSeatType {
        
        let stub = seatList[indexPath.section][indexPath.item]
        
        if stub.hall { // Hall area
            return .none
        } else if selectedSeatlist.contains(where: { $0.id == stub.id }) { // Selected
            return .selected
        } else if stub.salable { // Open for sale
            return .empty
        } else if stub.gender == true { // Full by man
            return .soldMan
        } else if stub.gender == false { // Full by woman
            return .soldWoman
        } else { // Else not a seat
            return .none
        }
    }
    
    func numberOfSections(in seatView: ALBusSeatView) -> Int {
        return seatList.count
    }
    
    func seatView(_ seatView: ALBusSeatView,
                  numberOfSeatInSection section: Int) -> Int {
        
        return seatList[section].count
    }
}
