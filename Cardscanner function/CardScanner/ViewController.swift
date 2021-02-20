//
//  ViewController.swift
//
//  Created by Ziang Liang on 01/18/2021.


import UIKit
import CardScanner

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var resultsLabel: UILabel!

    @IBAction func scanPaymentCard(_ sender: Any) {
        
        // Add NSCameraUsageDescription to your Info.plist
        let scannerView = CardScanner.getScanner { card, date, cvv in
            self.resultsLabel.text = "\(card) \(date) \(cvv)"
        }
        present(scannerView, animated: true, completion: nil)
    }
}
