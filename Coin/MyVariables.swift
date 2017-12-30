//
//  GlobalVariables.swift
//  Coin
//
//  Created by Jan Moravek on 13/12/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import Foundation

struct MyVariables {
    
    static var dataArray = [HomeLabel] ()
    static var timeStamp = ""
    static var finalURL = ""
    static var currentCurency = "USD"
    static let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/"
//    "https://apiv2.bitcoinaverage.com/indices/global/ticker/all?crypto=BTC,ETH,LTC&fiat=USD,EUR,CZK"
    static let currencyShortcutArray = ["CZK", "USD", "EUR"]
//    static var coinNameArray = ["Bitcoin","Ethereum","Litecoin"]
//    static var coinTickerArray = ["BTC","ETH","LTC"]
    
    static var coinNameArray = ["Bitcoin","Ethereum","Ripple","Litecoin","Monero","Zcash"]
    static var coinTickerArray = ["BTC","ETH","XRP","LTC","XMR","ZEC"]
    
    static var currencyControlSelected = 1
    
    static var ownedArray = [0, 0, 0, 0, 0, 0]
    
}
