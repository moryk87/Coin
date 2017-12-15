//
//  SecondViewController.swift
//  Coin
//
//  Created by Jan Moravek on 27/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let getData = GetData()
    
    @IBOutlet weak var cellTableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var currencyControl: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellTableView.delegate = self
        cellTableView.dataSource = self
        
        cellTableView.register(UINib(nibName: "PortfolioCell", bundle: nil), forCellReuseIdentifier: "portfolioCell")

        self.currencyControl.selectedSegmentIndex = MyVariables.currencyControlSelected
        
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
        
        let coinCell = tableView.dequeueReusableCell(withIdentifier: "portfolioCell", for: indexPath) as! PortfolioCell
        
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
    
    
    //coinCell.textCell.
    //[indexPath.row]
    
    
    
    
    //MARK: - IBAction
    /***************************************************************/
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        getData.storeData()
        print("refresh")
        
////        self.cellTableView.reloadData()
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

