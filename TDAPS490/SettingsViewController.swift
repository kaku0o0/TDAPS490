//
//  SettingsViewController.swift
//  TDAPS490
//
//  Created by Yangfan Li on 2021-03-11.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var emailField: UILabel!
    @IBOutlet weak var cardField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if nameField != nil && emailField != nil && cardField != nil{
            nameField.text? = defaults.string(forKey: "givenName")! + defaults.string(forKey: "lastName")!
            emailField.text? = defaults.string(forKey: "email")!
            let cardNum = Array(String(defaults.string(forKey: "cardNum")!))
            var cardText = ""
            for n in 0...15 {
                if n != 0 && n % 4 == 0 {
                    cardText += " "
                }
                cardText += String(cardNum[n])
            }
            cardField.text? = cardText
        }
    }
}
