//
//  HomeLabel.swift
//  Coin
//
//  Created by Jan Moravek on 30/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import Foundation

class HomeLabel {
    
    var coinNameCell : String
    var tickerCell : String
    var changeCell : Double = 0.00
    var priceCell : Double = 0.00
    var ownedCell : Double = 0.00
    
    init (coinNameCell: String, tickerCell: String) {
        self.coinNameCell = coinNameCell
        self.tickerCell = tickerCell
    }

}
