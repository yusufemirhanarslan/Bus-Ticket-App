//
//  LoginViewController.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 2.04.2023.
//

import UIKit
import CoreData
import Lottie

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var passwordTextField: UITextField!
    
    @IBOutlet private weak var mailTextField: UITextField!
    @IBOutlet weak var lottieAnimation: LottieAnimationView!
    
    var passengerModel = PassengerModel()
    var isControl = false
    var isFinished = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieAnimation.loopMode = .loop
        lottieAnimation.play()
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        let signupNavigationController = storyboard?.instantiateViewController(identifier: "signUpController") as! SignupViewController
        signupNavigationController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(signupNavigationController, animated: true)
    }
    @IBAction private func loginButton(_ sender: Any) {
        
        filteredValueFromData()
       
            if isControl {
                
                let homeViewController = storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
                homeViewController.passengerModel = passengerModel
                homeViewController.modalPresentationStyle = .fullScreen
                
                navigationController?.setViewControllers([homeViewController], animated: true)
                       
        }
}
                 
    
    
    
    private func filteredValueFromData() {
        
        // Core Data verileri Buraya Gelecek
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Passenger")
        //Filtreleme
        
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", argumentArray: [mailTextField.text!,passwordTextField.text!])
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                
                guard let name = result.value(forKey: "name") as? String,
                      let surname = result.value(forKey: "surname") as? String,
                      let email  = result.value(forKey: "email") as? String,
                      let password = result.value(forKey: "password") as? String,
                      let id = result.value(forKey: "id") as? UUID else { return }
                        
                passengerModel.name = name
                passengerModel.surname = surname
                passengerModel.email = email
                passengerModel.id = id
                passengerModel.password = password
                
                
//                ShowPopUpClass.showPopUp(description: "Giriş Başarılı", animationName: "success", sender: self )
//
//                Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { timer in
//                    self.isFinished = true
//                }
//
                isControl = true
            }
            
            if results.isEmpty {
                ShowPopUpClass.showPopUp(description: "Yanlış Şifre veya Mail adresi", animationName: "fail", sender: self)
            
            }
            
        } catch {
            
            isControl = false
            print("Veri çekerken sıkıntı oldu")
            
        }
        
        
        
    }
    
}
