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
    static var notificationArray = [NotificationLabel] ()
    static var ownedArray: [Float] = [0, 0, 0, 0, 0, 0]
    
    static var timeStamp = ""
    static var finalURL = ""
    static var currentCurency = "USD"
    static let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/"
//    "https://apiv2.bitcoinaverage.com/indices/global/ticker/all?crypto=BTC,ETH,LTC&fiat=USD,EUR,CZK"
    static let currencyShortcutArray = ["CZK", "USD", "EUR"]
    static var coinNameArray = ["Bitcoin","Ethereum","Ripple","Litecoin","Monero","Zcash"]
    static var coinTickerArray = ["BTC","ETH","XRP","LTC","XMR","ZEC"]
    static var conditionArray = ["reach","gain","lose"]
    
    static var deleteHidden = true
    static var edit = false
    
    static var currencyControlSelected = 1
    static var selectedNotificationIndex: Int = 0
}
