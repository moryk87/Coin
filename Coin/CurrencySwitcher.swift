//
//  CurrencySwitcher.swift
//  Coin
//
//  Created by Jan Moravek on 03/01/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import Foundation

class CurrencySwitcher {
    
    func switcher (sender: Int) {
        
        if sender == 0 {
            MyVariables.currentCurency = "CZK"
            MyVariables.currencyControlSelected = sender
            print("CZK")
        } else if sender == 1 {
            MyVariables.currentCurency = "USD"
            MyVariables.currencyControlSelected = sender
            print("USD")
        } else if sender == 2 {
            MyVariables.currentCurency = "EUR"
            MyVariables.currencyControlSelected = sender
            print("EUR")
        }
        
    }
}
