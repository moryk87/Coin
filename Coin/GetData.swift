//
//  UIViewController+Functions.swift
//  Coin
//
//  Created by Jan Moravek on 13/12/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GetData {
    
    var delegate: GetDataDelegate?
    
    //MARK: - Networking
    /***************************************************************/
    
    func downloadData(url: String, number: Int) {
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let dataJSON : JSON = JSON(response.result.value!)
                
                self.updateCoinData(json: dataJSON, number: number)
                
                print(url)
                //                print(dataJSON)
            } else {
                print("Error \(String(describing: response.result.error))")
                MyVariables.timeStamp = "Connection issues"
            }
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateCoinData(json: JSON, number: Int) {
        
        if let changeResult = json["changes"]["percent"]["day"].double {
            MyVariables.dataArray[number].changeCell = changeResult
            print("changeCell: \(MyVariables.dataArray[number].changeCell)")
        } else {
            MyVariables.timeStamp = "Change Unavailable"
        }
        
        if let priceResult = json["last"].double {
            MyVariables.dataArray[number].priceCell = priceResult
            print("priceCell: \(MyVariables.dataArray[number].priceCell)")
        } else {
            MyVariables.timeStamp = "Price Unavailable"
        }
        
        if let timeResult = json["display_timestamp"].string {
            MyVariables.timeStamp = timeResult
        } else {
            MyVariables.timeStamp = "Time Unavailable"
        }
        
        self.delegate?.didFinishGetData(finished: true)
    
        print("bb","\n")
    }
    
    //MARK: - storing Data
    /***************************************************************/
    
    func storeData () {
        for (n, _) in MyVariables.coinTickerArray.enumerated() {
            
            MyVariables.finalURL = MyVariables.baseURL+MyVariables.coinTickerArray[n]+MyVariables.currentCurency
            downloadData(url: MyVariables.finalURL, number: n)
            
            print(n)
        }
    }
    
    
}