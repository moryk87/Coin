//
//  GetData.swift
//  Coin
//
//  Created by Jan Moravek on 13/12/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol GetDataDelegate {
    func didFinishGetData(finished: Bool)
}

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
                
            } else {
                print("Error \(String(describing: response.result.error))")
                MyVariables.timeStamp = "Connection issues"
            }
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateCoinData(json: JSON, number: Int) {
        
        if let changeResult = json["changes"]["percent"]["day"].float {
            MyVariables.dataArray[number].changeCell = changeResult
        } else {
            MyVariables.timeStamp = "Change Unavailable"
        }
        
        if let priceResult = json["last"].float {
            MyVariables.dataArray[number].priceCell = priceResult
        } else {
            MyVariables.timeStamp = "Price Unavailable"
        }
        
        if let timeResult = json["display_timestamp"].string {
            MyVariables.timeStamp = timeResult
        } else {
            MyVariables.timeStamp = "Time Unavailable"
        }
        
        self.delegate?.didFinishGetData(finished: true)
    }
    
    //MARK: - storing Data
    /***************************************************************/
    
    func storeData () {
        for (n, _) in MyVariables.coinTickerArray.enumerated() {
            
            MyVariables.finalURL = MyVariables.baseURL+MyVariables.coinTickerArray[n]+MyVariables.currentCurency
            
            downloadData(url: MyVariables.finalURL, number: n)
        }
    }
    
}
