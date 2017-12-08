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
        
        for (n, _) in coinTickerArray.enumerated() {
//            print("\(n): '\(ticker)'")
            dataArray.append(HomeLabel(coinNameCell: coinNameArray[n], tickerCell: coinTickerArray[n]))
        }
        
        storeData()
        
    }
    
    //MARK: - tableView
    /***************************************************************/
    
    //3
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coinCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
        coinCell.coinNameCell.text = dataArray[indexPath.row].coinNameCell
        coinCell.tickerCell.text = dataArray[indexPath.row].tickerCell
        coinCell.changeCell.text = String(format: "%.2f", dataArray[indexPath.row].changeCell)+" %"
        coinCell.priceCell.text = String(format: "%.2f", dataArray[indexPath.row].priceCell)
        
        if dataArray[indexPath.row].changeCell >= 0 {
            coinCell.changeCell.textColor = UIColor(red:0.00, green:0.63, blue:0.00, alpha:1.0)
        } else {
            coinCell.changeCell.textColor = UIColor(red:0.87, green:0.23, blue:0.23, alpha:1.0)
        }
        
        return coinCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinTickerArray.count
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func getData(url: String, number: Int) {
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                let dataJSON : JSON = JSON(response.result.value!)
                
                self.updateCoinData(json: dataJSON, number: number)

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
    
    func updateCoinData(json: JSON, number: Int) {

        if let changeResult = json["changes"]["percent"]["day"].double {
            dataArray[number].changeCell = changeResult
            print("changeCell: \(dataArray[number].changeCell)")
        } else {
            timeStampLabel.text = "Change Unavailable"
        }

        if let priceResult = json["last"].double {
            dataArray[number].priceCell = priceResult
            print("priceCell: \(dataArray[number].priceCell)","\n")
        } else {
            timeStampLabel.text = "Price Unavailable"
        }

        if let timeResult = json["display_timestamp"].string {
            timeStampLabel.text = timeResult
        } else {
            timeStampLabel.text = "Time Unavailable"
        }
        
       self.cellTableView.reloadData()
    }

    //MARK: - storing Data
    /***************************************************************/
    
    func storeData () {
        for (n, _) in coinTickerArray.enumerated() {
            
            finalURL = baseURL+coinTickerArray[n]+currentCurency
            getData(url: finalURL, number: n)
        }
    }
    
    //MARK: - IBAction
    /***************************************************************/
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        self.cellTableView.reloadData()
    }
    
}

