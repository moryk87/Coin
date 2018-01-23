//
//  HomeViewController.swift
//  Coin
//
//  Created by Jan Moravek on 27/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeCellDelegate {

    let getData = GetData()
    let currencySwitcher = CurrencySwitcher ()
    
    @IBOutlet weak var cellTableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var currencyControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellTableView.delegate = self
        cellTableView.dataSource = self
        
        cellTableView.tableFooterView = UIView()
        
        cellTableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "homeCell")
        
        let myLoadedArray = UserDefaults.standard.array(forKey: "SavedFloatArray") as? [Float] ?? []
//        print("myLoadedArray: \(myLoadedArray)")

        if myLoadedArray .isEmpty {
            for (n, _) in MyVariables.coinTickerArray.enumerated() {

                 MyVariables.dataArray.append(HomeLabel(coinNameCell: MyVariables.coinNameArray[n], tickerCell: MyVariables.coinTickerArray[n], ownedCell: Float(MyVariables.ownedArray[n])))
            }
        } else {
            for (n, _) in MyVariables.coinTickerArray.enumerated() {

                MyVariables.dataArray.append(HomeLabel(coinNameCell: MyVariables.coinNameArray[n], tickerCell: MyVariables.coinTickerArray[n], ownedCell: myLoadedArray[n]))
                
                MyVariables.ownedArray[n] = myLoadedArray[n]
            }
        }
        
        getData.delegate = self
        getData.storeData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cellTableView.reloadData()
        self.currencyControl.selectedSegmentIndex = MyVariables.currencyControlSelected
    }
    
    
    //MARK: - tableView
    /***************************************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coinCell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        
        coinCell.coinNameCell.text = MyVariables.dataArray[indexPath.row].coinNameCell
        coinCell.tickerCell.text = MyVariables.dataArray[indexPath.row].tickerCell
        coinCell.changeCell.text = ((MyVariables.dataArray[indexPath.row].changeCell).withSeparator)+" %"
        coinCell.priceCell.text = (MyVariables.dataArray[indexPath.row].priceCell).withSeparator

        if MyVariables.dataArray[indexPath.row].changeCell >= 0 {
            coinCell.changeCell.textColor = UIColor(red:0.00, green:0.63, blue:0.00, alpha:1.0)
        } else {
            coinCell.changeCell.textColor = UIColor(red:0.87, green:0.23, blue:0.23, alpha:1.0)
        }
        
        coinCell.delegate = self
        
        return coinCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyVariables.coinTickerArray.count
    }
    
    
    //MARK: - buyButtonPressed
    /***************************************************************/
    
    func buyButtonPressed(didSelect coinCell: HomeCell) {
        let indexPath = self.cellTableView.indexPathForRow(at: coinCell.center)!

        guard let url = URL(string: "http://www.litebit.eu/en/buy/\(MyVariables.dataArray[indexPath.row].coinNameCell)") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
        print("BUY")
        print(indexPath.row)
        print(url)
    }
    
    
    //MARK: - IBAction
    /***************************************************************/
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        getData.storeData()
        self.cellTableView.reloadData()
    }

    @IBAction func currencyControlPressed(_ sender: UISegmentedControl) {
        currencySwitcher.switcher(sender: sender.selectedSegmentIndex)
        getData.storeData()
    }

}
