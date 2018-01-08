//
//  NotificationLabel.swift
//  Coin
//
//  Created by Jan Moravek on 04/01/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import Foundation

class NotificationLabel {
    
    var coinNameCell : String
    var tickerCell : String
    var conditionCell : String
    var valueCell : Float
    var currencyCell : String
    
    init (coinNameCell: String, tickerCell: String, conditionCell: String, valueCell: Float, currencyCell: String) {
        self.coinNameCell = coinNameCell
        self.tickerCell = tickerCell
        self.conditionCell = conditionCell
        self.valueCell = valueCell
        self.currencyCell = currencyCell
    }
}
