//
//  HomeLabel.swift
//  Coin
//
//  Created by Jan Moravek on 30/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import Foundation

class HomeLabel {
    
    let coinNameCell : String
    let tickerCell : String
    let changeCell : Double
    let priceCell : Double
    
    init (name: String, ticker: String, change: Double, last: Double) {
        
        coinNameCell = name
        tickerCell = ticker
        changeCell = change
        priceCell = last
    
    }
    //var coinNameArray = ["Bitcoin","Ethereum","Ripple","Dash","Litecoin","Monero","NEM"]
    //var coinTickerArray = ["BTC","ETH","XRP","DASH","LTC","XMR","XEM"]
}
