//
//  FirstViewController.swift
//  Coin
//
//  Created by Jan Moravek on 27/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/"
    var finalURL = ""
    //"https://apiv2.bitcoinaverage.com/indices/global/ticker/all?crypto=BTC,ETH,LTC&fiat=USD,EUR,CZK"
    let currencyShortcutArray = ["CZK", "USD", "EUR"]
    var currentCurency = "USD"
    
    var coinNameArray = ["Bitcoin","Ethereum","Litecoin"]
    var coinTickerArray = ["BTC","ETH","LTC"]
    //var coinNameArray = ["Bitcoin","Ethereum","Ripple","Dash","Litecoin","Monero","NEM"]
    //var coinTickerArray = ["BTC","ETH","XRP","DASH","LTC","XMR","XEM"]
    
    var dataArray = [HomeLabel] ()
    var storeArray : Double = 0.00
    var flo : Double = 0.00
    
    let messageArray: [StoreArray] = [StoreArray] ()
    
    struct StoreArray {

        var tickerCell : String = ""
        var changeCell : Double = 0.00
        var priceCell : Double = 0.00
    }
    
    //1
    @IBOutlet weak var cellTableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2
        cellTableView.delegate = self
        cellTableView.dataSource = self
        
        //4
        cellTableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        for (n, ticker) in coinTickerArray.enumerated() {
//            print("\(n): '\(ticker)'")
            dataArray.append(HomeLabel(coinNameCell: coinNameArray[n], tickerCell: coinTickerArray[n]))
        }
        
        print(dataArray[2].coinNameCell)
        print(dataArray[1].tickerCell)
        print(dataArray[0].changeCell, "\n")
        
    }
    
    //3
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coinCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
        coinCell.coinNameCell.text = dataArray[indexPath.row].coinNameCell
        coinCell.tickerCell.text = dataArray[indexPath.row].tickerCell
        coinCell.priceCell.text = String(dataArray[indexPath.row].changeCell)
        coinCell.changeCell.text = String(dataArray[indexPath.row].priceCell)
        
        finalURL = baseURL+coinTickerArray[indexPath.row]+currentCurency
        
        getData(url: finalURL)
        
        return coinCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinTickerArray.count
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getData(url: String) {
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let dataJSON : JSON = JSON(response.result.value!)
                
                self.updateCoinData(json: dataJSON)

                print(url)
                print(dataJSON)
            } else {
                print("Error \(String(describing: response.result.error))")
                self.timeStampLabel.text = "Connection issues"
            }
        }
    }
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateCoinData(json: JSON) {

        if let changeResult = json["changes"]["percent"]["day"].double {
     
            print(changeResult)
            storeArray = changeResult
            messageArray.append
            print("storeArray: \(storeArray)")
        } else {
            timeStampLabel.text = "XXX Unavailable"
        }

        if let priceResult = json["last"].double {
            print(priceResult)
            flo = priceResult
            print("flo: \(flo)")
        } else {
            timeStampLabel.text = "Price is Unavailable"
        }

        let sender = snapshotValue["Sender"]!
        let text = snapshotValue["MessageBody"]!
        
        let message = Message ()
        message.sender = sender
        message.messageBody = text
        
        self.messageArray.append(message)
        
//        if let timeResult = json["display_timestamp"].string {
//            timeStampLabel.text = timeResult
//
//        } else {
//            timeStampLabel.text = "Price Unavailable"
//        }
        
    }

    
    func storeData () {
        for (n, _) in coinTickerArray.enumerated() {
            
            finalURL = baseURL+coinTickerArray[n]+currentCurency
            
            getData(url: finalURL)
            
            dataArray[n].changeCell = storeArray
            dataArray[n].priceCell = flo
            
            //reload.tableview
        }
    }
    
    
    
    
        
    
    
    
//    func updateUI {
//
//    }
    
}

