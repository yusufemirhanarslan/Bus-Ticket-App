//
//  PaymentViewController.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 7.04.2023.
//

import UIKit
import CoreData

class PaymentViewController: UIViewController {
    
    
    @IBOutlet weak var fromLabel: UILabel!
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextFİeld: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var ticketModel = TicketModel()
    var text: String!
    var priceText: String!
    
    var name: String!
    var surname: String!
    var email: String!
    var password: String!
    var id: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ödeme Adımına Hoşgeldiniz"
        
        name = UserDefaults.standard.string(forKey: "name")
        surname = UserDefaults.standard.string(forKey: "surname")
        email = UserDefaults.standard.string(forKey: "email")
        id =  UserDefaults.standard.string(forKey: "id")
        password = UserDefaults.standard.string(forKey: "password")
        
        fromLabel.text = ticketModel.fromLocation + "(OTOGAR)"
        toLabel.text = ticketModel.toLocation + "(OTOGAR)"
        dateLabel.text = "\(ticketModel.dateDay)" + " / " + "\(ticketModel.dateMonth)" + " / " + "\(ticketModel.dateYear)"
        priceLabel.text = "\(ticketModel.totalSeatPrice * ticketModel.seatNumbers.count) TL"
        seatLabel.text = String(describing: ticketModel.seatNumbers.sorted().map { String($0) }.joined(separator: ","))
        mailTextField.text = self.email
        nameTextField.text = self.name + " " + self.surname
        hourLabel.text = ticketModel.hour
        
        let name = "Adınız: \(String(describing: self.name))"
        let surname = "Soyadınız: \(String(describing: self.surname))"
        let fromText = "Nereden: \(ticketModel.fromLocation)"
        let toText = "Nereye: \(ticketModel.toLocation)"
        let seatText = "Koltuk Numaraları: \(ticketModel.seatNumbers)"
        priceText = "Toplam Fiyat: \(String(describing: priceLabel.text))"
        let moveDate = "Ne zaman: \(ticketModel.dateDay)" + " / " + "\(ticketModel.dateMonth)" + " / " + "\(ticketModel.dateYear)"
        let hourText = "Saat Kaçta: \(ticketModel.hour)"
        let seperator = "\n"
        
        text = name + seperator + surname + seperator + fromText + seperator + toText + seperator + seatText + seperator + priceText + seperator + moveDate + seperator + hourText
        
        
    }
    func checkTextFields() -> Bool {
        
        if phoneNumberTextFİeld.text != "" && mailTextField.text != "" && nameTextField.text != "" {
            return true
        }
        
        return false
        
    }
    
    
    @IBAction func safetyPay(_ sender: Any) {
        
        if checkTextFields() {
            saveData()
            
            let presentTicketViewController = storyboard?.instantiateViewController(withIdentifier: "presentTicketVC") as! PresentTicketsViewController
            presentTicketViewController.modalPresentationStyle = .fullScreen
            navigationController?.setViewControllers([presentTicketViewController], animated: true)
            
        }else {
            AlertDialog.showAlert(alertTitle: "Dikkat", alertMessage: "Lütfen Boş Yer Bırakmayınız", defaultTitle: "Ok", cancelTitle: "İptal", viewController: self)
            
        }
    }
    
    
    func saveData() {
        
        let qrImagePress = generateQrCode(from: text)?.jpegData(compressionQuality: 0.5)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // appdelegate'e erişiyoruz
        let context = appDelegate.persistentContainer.viewContext
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "Ticket", into: context)
        
        saveData.setValue(ticketModel.fromLocation, forKey: "fromLocation")
        saveData.setValue(ticketModel.toLocation, forKey: "toLocation")
        saveData.setValue(ticketModel.seatNumbers, forKey: "seatNumbers")
        saveData.setValue(priceText, forKey: "price")
        saveData.setValue(phoneNumberTextFİeld.text, forKey: "phoneNumber")
        saveData.setValue(ticketModel.dateDay, forKey: "dateDay")
        saveData.setValue(ticketModel.dateMonth, forKey: "dateMonth")
        saveData.setValue(ticketModel.dateYear, forKey: "dateYear")
        saveData.setValue(ticketModel.hour, forKey: "hour")
        saveData.setValue(qrImagePress, forKey: "qrImage")
        
        do {
            try context.save()
            print("Success")
        }catch{
            print("Error")
        }
        
    }
    
    func generateQrCode(from string: String) -> UIImage? {
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            
            filter.setValue(text.data(using: .utf8), forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
            
        }
        return nil
        
    }
    
    
}
