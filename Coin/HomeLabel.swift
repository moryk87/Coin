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
    var changeCell : Float = 0.0
    var priceCell : Float = 0.0
    var ownedCell : Float
    
    init (coinNameCell: String, tickerCell: String, ownedCell: Float) {
        self.coinNameCell = coinNameCell
        self.tickerCell = tickerCell
        self.ownedCell = ownedCell
    }
}
