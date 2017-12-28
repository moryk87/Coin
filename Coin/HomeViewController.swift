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

    let getData = GetData()
    
    //1
    @IBOutlet weak var cellTableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var currencyControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2
        cellTableView.delegate = self
        cellTableView.dataSource = self
        
        //4
        cellTableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "homeCell")
        
        for (n, _) in MyVariables.coinTickerArray.enumerated() {
//            print("\(n): '\(ticker)'")
            MyVariables.dataArray.append(HomeLabel(coinNameCell: MyVariables.coinNameArray[n], tickerCell: MyVariables.coinTickerArray[n]))
        }
        
        getData.delegate = self
        
        print(MyVariables.currencyControlSelected)
//        storeData()
        getData.storeData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cellTableView.reloadData()
        self.currencyControl.selectedSegmentIndex = MyVariables.currencyControlSelected
    }
    
    //MARK: - tableView
    /***************************************************************/
    
    //3
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coinCell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        
        coinCell.coinNameCell.text = MyVariables.dataArray[indexPath.row].coinNameCell
        coinCell.tickerCell.text = MyVariables.dataArray[indexPath.row].tickerCell
        
        coinCell.changeCell.text = ((MyVariables.dataArray[indexPath.row].changeCell).withSeparator)+" %"
        
//        coinCell.priceCell.text = String(format: "%.2f", dataArray[indexPath.row].priceCell)

        coinCell.priceCell.text = (MyVariables.dataArray[indexPath.row].priceCell).withSeparator

        if MyVariables.dataArray[indexPath.row].changeCell >= 0 {
            coinCell.changeCell.textColor = UIColor(red:0.00, green:0.63, blue:0.00, alpha:1.0)
        } else {
            coinCell.changeCell.textColor = UIColor(red:0.87, green:0.23, blue:0.23, alpha:1.0)
        }
        
        return coinCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyVariables.coinTickerArray.count
    }
    
    
//    //MARK: - Networking
//    /***************************************************************/
//
//    func downloadData(url: String, number: Int) {
//
//        Alamofire.request(url, method: .get).responseJSON {
//            response in
//            if response.result.isSuccess {
//                let dataJSON : JSON = JSON(response.result.value!)
//
//                self.updateCoinData(json: dataJSON, number: number)
//
//                print(url)
////                print(dataJSON)
//            } else {
//                print("Error \(String(describing: response.result.error))")
//                self.timeStampLabel.text = "Connection issues"
//            }
//        }
//    }
//
//
//    //MARK: - JSON Parsing
//    /***************************************************************/
//
//    func updateCoinData(json: JSON, number: Int) {
//
//        if let changeResult = json["changes"]["percent"]["day"].double {
//            MyVariables.dataArray[number].changeCell = changeResult
//            print("changeCell: \(MyVariables.dataArray[number].changeCell)")
//        } else {
//            timeStampLabel.text = "Change Unavailable"
//        }
//
//        if let priceResult = json["last"].double {
//            MyVariables.dataArray[number].priceCell = priceResult
//            print("priceCell: \(MyVariables.dataArray[number].priceCell)","\n")
//        } else {
//            timeStampLabel.text = "Price Unavailable"
//        }
//
//        if let timeResult = json["display_timestamp"].string {
//            timeStampLabel.text = timeResult
//            print(timeResult)
//        } else {
//            timeStampLabel.text = "Time Unavailable"
//        }
//
//       self.cellTableView.reloadData()
//    }
//    
//    //MARK: - storing Data
//    /***************************************************************/
//    
//    func storeData () {
//        for (n, _) in MyVariables.coinTickerArray.enumerated() {
//            
//            MyVariables.finalURL = MyVariables.baseURL+MyVariables.coinTickerArray[n]+MyVariables.currentCurency
//            downloadData(url: MyVariables.finalURL, number: n)
//            
//            print(n)
//        }
//    }
    
    
    //MARK: - IBAction
    /***************************************************************/
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        getData.storeData()
        print("refresh")
        self.cellTableView.reloadData()
//        self.didFinishGetData(finished: true)
    }

    @IBAction func currencyControlPressed(_ sender: UISegmentedControl) {

        if sender.selectedSegmentIndex == 0 {
            MyVariables.currentCurency = "CZK"
            MyVariables.currencyControlSelected = sender.selectedSegmentIndex
            print("CZK")
        } else if sender.selectedSegmentIndex == 1 {
            MyVariables.currentCurency = "USD"
            MyVariables.currencyControlSelected = sender.selectedSegmentIndex
            print("USD")
        } else if sender.selectedSegmentIndex == 2 {
            MyVariables.currentCurency = "EUR"
            MyVariables.currencyControlSelected = sender.selectedSegmentIndex
            print("EUR")
        }
        
        getData.storeData()
    }
    

}
