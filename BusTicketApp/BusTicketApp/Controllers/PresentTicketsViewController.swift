//
//  PresentTicketsViewController.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 10.04.2023.
//

import UIKit
import CoreData

class PresentTicketsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var count: Int!
    var fromText: String!
    var toText: String!
    var hourText: String!
    var dateDayText: Int!
    var dateYearText: Int!
    var dateMonthText: Int!
    var priceText: Int!
    var phoneNumberText: String!
    var qrImage: UIImage!
    var seatNumbers: [Int]!
    var ticketModel = TicketModel()
    var qrImageModel = QrModel()
    
    var ticketModelArray = [TicketModel]()
    var qrImageModelArray = [QrModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CustomTicketsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        getData()
        
    }
    
    @IBAction func backToHomePage(_ sender: Any) {
        
        let homeViewController = storyboard?.instantiateViewController(identifier: "homeViewController") as! HomeViewController
        homeViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(homeViewController, animated: true)
        
    }
    
    func getData() {
       
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ticket")
        fetchRequest.returnsObjectsAsFaults = false // uygulamanın hızını performansını arttırıyor.
        
        do {
            let results = try context.fetch(fetchRequest)
            count = results.count
            for result in results as! [NSManagedObject] {
                
                if let fromLocation = result.value(forKey: "fromLocation") as? String {
                    fromText = fromLocation
                }
                if let toLocation = result.value(forKey: "toLocation") as? String {
                    toText = toLocation
                }
                if let dateDay = result.value(forKey: "dateDay") as? Int {
                    dateDayText = dateDay
                }
                if let dateMonth = result.value(forKey: "dateMonth") as? Int {
                    dateMonthText = dateMonth
                }
                if let dateYear = result.value(forKey: "dateYear") as? Int {
                    dateYearText = dateYear
                }
                if let qrImageimage = result.value(forKey: "qrImage") as? Data {
                    qrImage = UIImage(data: qrImageimage)
                }
                if let moveHour = result.value(forKey: "hour") as? String {
                    hourText = moveHour
                }
                if let price = result.value(forKey: "price") as? String {
                    priceText = Int(price)
                }
                if let seatText = result.value(forKey: "seatNumbers") as? [Int]{
                    seatNumbers = seatText
                }
                if let phoneText = result.value(forKey: "phoneNumber") as? String{
                    phoneNumberText = phoneText
                }
                setupTicket()
                    
            }
            
        } catch {
            
        }
        
    }
    
    func setupTicket() {
        
        ticketModel = TicketModel(fromLocation: fromText,
                                  toLocation: toText,
                                  dateDay: dateDayText,
                                  dateMonth: dateMonthText,
                                  dateYear: dateYearText,
                                  seatNumbers: seatNumbers,
                                  totalSeatPrice: 100,
                                  passenger: PassengerModel(name: "Yusuf",surname: "Arslan",email: "qwdıuw@example.com",password: "12345",id: UUID()),
                                  hour: hourText)
        qrImageModel = QrModel(qrImage: self.qrImage)
        
        ticketModelArray.append(ticketModel)
        qrImageModelArray.append(qrImageModel)
        
    }
    
}


extension PresentTicketsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTicketsTableViewCell
        
        cell.setup(ticketModelArray[indexPath.row], qrImageModelArray[indexPath.row])
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 500
    }
    
    
}
