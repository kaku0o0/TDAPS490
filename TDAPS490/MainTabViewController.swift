//
//  MainTabViewController.swift
//  TDAPS490
//
//  Created by Yangfan Li on 2021-03-11.
//

import UIKit

class MainTabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func onClick(_ sender: Any) {
        if let url = URL(string: "https://www.td.com/ca/en/personal-banking/how-to/ways-to-save/ways-to-help-you-save-money") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}
