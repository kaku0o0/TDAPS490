//
//  CurrencyConverter.swift
//  TDAPS490
//
//  Created by Kakujojo on 2021-02-26.
//

import UIKit


struct CurrencyPrice {
    var currency : String;
    var foreignAmount : Double
    var amount : Double;
    var formattedAmount : String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = currency
        f.currencyGroupingSeparator = " "
        f.alwaysShowsDecimalSeparator = false
        return f.string(for: amount)!
    }
    var country : String
    var friendlyCurrency : String
}


class CurrencyConverter: NSObject {

    func convert(fromImageName i : String, targetCurrency:String) -> CurrencyPrice {
        let p = price(fromImageName: i)
        let c = convertToCAD(currencyPrice: p)
        return c
    }
    
    // --
    
    func format(amount : Double, currency : String) -> String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = currency
        f.currencyGroupingSeparator = " "
        f.alwaysShowsDecimalSeparator = false
        return f.string(for: amount)!
    }

    func price(fromImageName i : String) -> CurrencyPrice {
        let s = i.split(separator: "-") // e.g. 5-CAD-A
        let cp = CurrencyPrice(
            currency: "\(s[1])",
            foreignAmount: Double(s[0])!,
            amount: Double(s[0])!,
            country: (ratesToCAD["\(s[1])"]?.country)!,
            friendlyCurrency: (ratesToCAD["\(s[1])"]?.friendlyCurrency)!)
        return cp
    }
    
    func convertToCAD(currencyPrice p : CurrencyPrice) -> CurrencyPrice {
        let calc = ratesToCAD[p.currency]!
        return CurrencyPrice(
            currency: "CAD",
            foreignAmount: p.amount,
            amount: calc.rate * p.amount,
            country: calc.country,
            friendlyCurrency: calc.friendlyCurrency)
    }
    
    
    let ratesToCAD = [
        "USD" : (rate: 1.27, country: "United States", friendlyCurrency:"USA Dollars"),
        "CAD" : (rate: 1, country: "Canada", friendlyCurrency:"Canadian Dollars")
    ]
    
}


