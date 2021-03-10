//
//  LoginViewController.swift
//  TDAPS490
//
//  Created by Yangfan Li on 2021-02-27.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)
    }
    //Calls this function when the tap
    @objc func dismissKeyboard() {

        view.endEditing(true)
    }
    @IBAction func onLogin(_ sender: Any) {
        let defaults = UserDefaults.standard
        if email.text?.isEmpty ?? true || password.text?.isEmpty ?? true || defaults.string(forKey: "email") != email.text || defaults.string(forKey: "password") != password.text {
            errorMsg.text = "Please check your credentials"
        } else {
            self.performSegue(withIdentifier: "LoginToMain", sender: nil)
        }
    }

    @IBAction func onCreateNewAcc(_ sender: Any) {
        self.performSegue(withIdentifier: "ToRegister", sender: nil)
    }

    @IBAction func OnToggleLoginSwitch(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        defaults.set(sender.isOn, forKey: "KeepMeLoggedIn")
    }
}
