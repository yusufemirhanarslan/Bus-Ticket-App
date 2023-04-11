//
//  BusViewController.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 6.04.2023.
//

import UIKit

class BusViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = -1
    var isCollapce = false
    
    var moveModel = MoveModel()
    var dataManager = SeatDataManager()
    var ticketModel = TicketModel()
    var passengerModel = PassengerModel()
    var seatNumbers = [Int]()
    
    var busInformation: [BusInformationModel] = []
    var busViewCell: CutomBusTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = moveModel.fromLocation + " 🚌 " + moveModel.toLocation + " " + "\(moveModel.dateDay)" + " / " + "\(moveModel.dateMonth)" + " / " + "\(moveModel.dateYear)"
        
        let nib = UINib(nibName: "CutomBusTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        // For Max Seat Numbers
        NotificationCenter.default.addObserver(self, selector: #selector(customShowPopUp), name:.maxSelected, object: nil)
        
        // Next Button
        NotificationCenter.default.addObserver(self, selector: #selector(nextButton), name: .nextButton, object: nil)
        
        // Selected Seat Numbers
        NotificationCenter.default.addObserver(self, selector: #selector(seatNumbers(_:)), name: .seatNumbersInController, object: nil)
        
        
        tableView.estimatedRowHeight = 557
        tableView.rowHeight = UITableView.automaticDimension
        
        
        busInformation = [
            BusInformationModel(brandName: "Kamil Koç",
                                moveHour: "09.30",
                                ticketPrice: "100",
                                brandImage: UIImage(named: "kamil-koc")!,
                                fromLocation: moveModel.fromLocation,
                                toLocation: moveModel.toLocation),
            
            BusInformationModel(brandName: "Efe Tur",
                                moveHour: "11.30", ticketPrice: "200",
                                brandImage: UIImage(named: "efe-tur")!,
                                fromLocation: moveModel.fromLocation,
                                toLocation: moveModel.toLocation),
            
            BusInformationModel(brandName: "Sivas Huzur Turizm",
                                moveHour: "13.30",
                                ticketPrice: "300",
                                brandImage: UIImage(named: "sivas-huzur")!,
                                fromLocation: moveModel.fromLocation,
                                toLocation: moveModel.toLocation),
            
            
            BusInformationModel(brandName: "As Adana",
                                moveHour: "15.30",
                                ticketPrice: "400",
                                brandImage: UIImage(named: "as-adana")!,
                                fromLocation: moveModel.fromLocation,
                                toLocation: moveModel.toLocation),
            
            
            BusInformationModel(brandName: "Pamukkale",
                                moveHour: "17.30",
                                ticketPrice: "500",
                                brandImage: UIImage(named: "pamukkale")!,
                                fromLocation: moveModel.fromLocation,
                                toLocation: moveModel.toLocation),
            
        ]
        
        
    }
    
    @objc func customShowPopUp() {
        
        ShowPopUpClass.showPopUp(description: "5 Taneden Fazla Koltuk Seçemezsiniz", animationName: "attention", sender: self)
        
    }
    
    @objc func seatNumbers(_ data :Notification) {
        
        if let data = data.userInfo {
            
            let result = data["seatNumber"] as! [Int]
            seatNumbers = result
            
        }
        
    }
    
    func ticketInformation() {
        
        ticketModel.fromLocation = moveModel.fromLocation
        ticketModel.toLocation = moveModel.toLocation
        ticketModel.dateDay = moveModel.dateDay
        ticketModel.dateMonth = moveModel.dateMonth
        ticketModel.dateYear = moveModel.dateYear
        ticketModel.seatNumbers = seatNumbers
        ticketModel.passengerModel = PassengerModel(name: passengerModel.name, surname: passengerModel.surname, email: passengerModel.email)
        
    }
    
    @objc func nextButton() {
        
        ticketInformation()
        
        let paymentViewController = storyboard?.instantiateViewController(withIdentifier: "paymentViewController") as! PaymentViewController
        paymentViewController.modalPresentationStyle = .fullScreen
        paymentViewController.ticketModel = ticketModel
        //present(paymentViewController, animated: true)
        navigationController?.pushViewController(paymentViewController, animated: true)
    }
    
}

extension BusViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return busInformation.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CutomBusTableViewCell
        
        cell.setup(busInformation[indexPath.row])
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.selectedIndex == indexPath.row && isCollapce == true {
            
            return 557
        } else {
            return 100
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        ticketModel.hour = busInformation[indexPath.row].moveHour
        ticketModel.totalSeatPrice = Int(busInformation[indexPath.row].ticketPrice)!
        if selectedIndex == indexPath.row {
            
            if self.isCollapce == false {
                
                self.isCollapce = true
            } else {
                self.isCollapce = false
            }
        } else {
            self.isCollapce = true
        }
        
        self.selectedIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
}
