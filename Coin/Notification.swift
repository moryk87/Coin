//
//  Notification.swift
//  Coin
//
//  Created by Jan Moravek on 17/01/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import Foundation
import Alamofire

class Notification {
   
    func sendPush (coinNameCell: String, tickerCell: String, conditionCell: String, valueCell: Float, currencyCell: String) {
        
        let head: HTTPHeaders = [
            "Content-Type":"application/json",
            "Authorization":"key=AAAAxR8ZrTc:APA91bFbplcPQydyGO9J5UzGl39drzUxCS77TebCO7OHwu_M0zPMzRh2yJOqgwTZt4YtrRYIYgKGHW2qSbV7fKrlcPv54wy-8BMGcJAY8EWT9jNmopobLnvkltZKFiKIDz6lWkj83Q6h"]
        
        let para: Parameters = [
            "notification":
                [
                    //                "title": "Venue change for Avengers secret meet",
                    "body": "\(coinNameCell) (\(tickerCell)) \(conditionCell) \(valueCell) \(currencyCell)"
            ],
            "to": MyVariables.token
        ]
        
        let request = Alamofire.request("https://fcm.googleapis.com/fcm/send", method: HTTPMethod.post , parameters: para, encoding: JSONEncoding.default, headers: head).responseJSON { response in
//            debugPrint(response)
        }
//        debugPrint(request)
    }
    
}
