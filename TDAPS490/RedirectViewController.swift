//
//  RedirectViewController.swift
//  TDAPS490
//
//  Created by Yangfan Li on 2021-02-27.
//

import UIKit

class RedirectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "KeepMeLoggedIn") {
            // To main page
            self.performSegue(withIdentifier: "StartToMain", sender: nil)
        } else if defaults.string(forKey: "email") != nil {
            self.performSegue(withIdentifier: "ToLogin", sender: nil)
        } else {
            self.performSegue(withIdentifier: "NoLoginRedirect", sender: nil)
        }
    }
}
