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
    //"https://apiv2.bitcoinaverage.com/indices/global/ticker/all?crypto=BTC,ETH,LTC&fiat=USD,EUR,CZK"
    let currencyShortcutArray = ["CZK", "USD", "EUR"]
    var currentCurency = "CZK"
    var coinNameArray = ["Bitcoin","Ethereum","Litecoin"]
    //var coinNameArray = ["Bitcoin","Ethereum","Ripple","Dash","Litecoin","Monero","NEM"]
    var coinTickerArray = ["BTC","ETH","LTC"]
    //var coinTickerArray = ["BTC","ETH","XRP","DASH","LTC","XMR","XEM"]
    var finalURL = ""

    let homeLabel = HomeLabel ()
    
    
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
        
    }
    
    //3
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coinCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
        coinCell.coinNameCell.text = coinNameArray[indexPath.row]
        coinCell.tickerCell.text = coinTickerArray[indexPath.row]
        
        print(coinTickerArray[indexPath.row])
        
        finalURL = baseURL+coinTickerArray[indexPath.row]+currentCurency

        getData(url: finalURL)

        
//        changeCell
//        priceCell
        
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
            
        
        
//        timestmap
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateCoinData(json: JSON) -> Double {

//        if let changeResult = json["changes"]["percent"]["day"].double {
//            coinCell.changeCell.text = changeResult
//
//        } else {
//            timeStampLabel.text = "Price Unavailable"
//
//        }

        let priceResult = json["last"].double
        print(priceResult)
        
//        if let timeResult = json["display_timestamp"].string {
//            timeStampLabel.text = timeResult
//
//        } else {
//            timeStampLabel.text = "Price Unavailable"
//        }
        
        return priceResult!
    }
    
//    func updateUI {
//
//    }
    
}

