//
//  CustomTicketsTableViewCell.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 10.04.2023.
//

import UIKit

class CustomTicketsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var fromLabelText: UILabel!
    
    @IBOutlet weak var toLabelText: UILabel!
    
    @IBOutlet weak var hourLabelText: UILabel!
    @IBOutlet weak var dateLabelText: UILabel!
    
    @IBOutlet weak var priceLabelText: UILabel!
    @IBOutlet weak var qrImageView: UIImageView!
    @IBOutlet weak var seatsLabelText: UILabel!
    @IBOutlet weak var passengerName: UILabel!
    
    
    func setup(_ ticketModel: TicketModel, _ qrModel: QrModel){
        
        fromLabelText.text = ticketModel.fromLocation
        toLabelText.text = ticketModel.toLocation
        hourLabelText.text = ticketModel.hour
        dateLabelText.text = "\(ticketModel.dateDay)/\(ticketModel.dateMonth)/\(ticketModel.dateYear)"
        qrImageView.image = qrModel.qrImage
        seatsLabelText.text = "\(ticketModel.seatNumbers.sorted().map{ String($0) }.joined(separator: ","))"
        passengerName.text = ticketModel.passengerModel.name + " " + ticketModel.passengerModel.surname
        priceLabelText.text = "\(ticketModel.totalSeatPrice) TL"
    }
}
