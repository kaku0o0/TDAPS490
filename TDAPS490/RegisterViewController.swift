//
//  MainViewController.swift
//  TDAPS490
//
//  Created by Yangfan Li on 2021-02-27.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // First page
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var givenName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    // Second page
    @IBOutlet weak var nameField: UILabel!

    // Third page
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardPassword: UITextField!
    @IBOutlet weak var connectToBankButton: UIButton!
    @IBOutlet weak var cardErrorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        //Looks for taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
        defaults.set(false, forKey: "KeepMeLoggedIn")

        if nameField != nil {
            nameField.text? = "Hi, " + defaults.string(forKey: "givenName")!
        }

        if registerButton != nil {
            registerButton.isHidden = true
            registerButton.isEnabled = false
        }

    }
    //Calls this function when the tap 
    @objc func dismissKeyboard() {

        view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
    //        self.performSegue(withIdentifier: "pushSignUp", sender: self)
    }

    
    @IBAction func agreeTofU(_ sender: UISwitch) {
        registerButton.isHidden = !sender.isOn
        registerButton.isEnabled = sender.isOn
    }
    
    @IBAction func resetError(_ sender: UITextField) {
        errorMessage.text = ""
    }

    @IBAction func onRegister(_ sender: UIButton) {
        var error = ""
        if givenName.text?.isEmpty ?? true {
            error = "Please enter your first name"
        } else if lastName.text?.isEmpty ?? true {
            error = "Please enter your last name"
        } else if emailAddress.text?.isEmpty ?? true {
            error = "Please enter your email address"
        } else if password.text?.isEmpty ?? true {
            error = "Please enter your password"
        } else if repeatPassword.text?.isEmpty ?? true {
            error = "Please enter your repeat password"
        } else if password.text?.elementsEqual(repeatPassword.text!) != true {
            error = "Please make sure that passwords match"
        }
        
        if error != "" {
            errorMessage.text = error
        } else {
            let defaults = UserDefaults.standard
            defaults.set(givenName.text!, forKey: "givenName")
            defaults.set(lastName.text!, forKey: "lastName")
            defaults.set(emailAddress.text!, forKey: "email")
            defaults.set(password.text!, forKey: "password")
            defaults.synchronize()
            performSegue(withIdentifier: "registerSuccess", sender: nil)
        }
    }

    @IBAction func onConnectToBank(_ sender: UIButton) {
        var error = ""
        if cardNumber.text?.isEmpty ?? true || String(cardNumber.text!).count < 16 {
            error = "Please double check your card number or account number"
        } else if cardPassword.text?.isEmpty ?? true {
            error = "Please double check your account password"
        }
        
        if error != "" {
            cardErrorMessage.text = error
        } else {
            let defaults = UserDefaults.standard
            defaults.set(cardNumber.text!, forKey: "cardNum")
            defaults.synchronize()
            performSegue(withIdentifier: "connectToBankSuccess", sender: nil)
        }
    }

    @IBAction func onAccNumInput(_ sender: UITextField) {
        if !(sender.text?.isEmpty ?? true) {
            var error = ""
            if cardPassword.text?.isEmpty ?? true {
                error = "Please enter your account password"
            }
            cardErrorMessage.text = error
        }
    }
    
    @IBAction func onAccPwdInput(_ sender: UITextField) {
        if !(sender.text?.isEmpty ?? true) {
            var error = ""
            if cardNumber.text?.isEmpty ?? true {
                error = "Please enter your card number or account number"
            }
            cardErrorMessage.text = error
        }
    }
    
    @IBAction func onLoggedInSwitch(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        defaults.set(sender.isOn, forKey: "KeepMeLoggedIn")
    }
    
    
    @IBAction func onContinue(_ sender: Any) {
        self.performSegue(withIdentifier: "RegToMain", sender: nil)
    }
}
