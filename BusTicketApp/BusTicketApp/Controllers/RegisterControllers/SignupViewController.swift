//
//  SignupViewController.swift
//  BusTicketApp
//
//  Created by Yusuf Emirhan Arslan on 2.04.2023.
//

import UIKit
import CoreData
import Lottie

class SignupViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
   
    @IBOutlet weak var lottieAnimationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //let dataFormatter = DateFormatter()
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
        
    }

    
    @IBAction func signupButton(_ sender: Any) {
        
        // Veri Kaydetme İşlemi
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // appdelegate'e erişiyoruz
        let context = appDelegate.persistentContainer.viewContext
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "Passenger", into: context)
        
        if (nameTextField.text != "" && passwordTextField.text != "" && emailTextField.text != "" && surnameTextField.text != ""){
       
            saveData.setValue(nameTextField.text!, forKey: "name")
            saveData.setValue(surnameTextField.text!, forKey: "surname")
            saveData.setValue(emailTextField.text!, forKey: "email")
            saveData.setValue(passwordTextField.text!, forKey: "password")
            saveData.setValue(UUID(), forKey: "id")
            
            
        }
         do {
            try context.save()
                print("Success")
             let loginNavigationController = storyboard?.instantiateViewController(identifier: "loginNavigationController") as! LoginViewController
             loginNavigationController.modalPresentationStyle = .fullScreen
             navigationController?.setViewControllers([loginNavigationController], animated: true)
             
        }catch{
            print("Error")
        }
        
        
        
    }
    
    

}
