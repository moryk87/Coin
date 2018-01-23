//
//  PortfolioViewController.swift
//  Coin
//
//  Created by Jan Moravek on 27/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PortfolioCellDelegate {
    
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
        
        cellTableView.register(UINib(nibName: "PortfolioCell", bundle: nil), forCellReuseIdentifier: "portfolioCell")

        self.currencyControl.selectedSegmentIndex = MyVariables.currencyControlSelected
        
        getData.delegate = self
        
        timeStampLabel.text = MyVariables.timeStamp
    
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cellTableView.reloadData()
        self.currencyControl.selectedSegmentIndex = MyVariables.currencyControlSelected
        self.timeStampLabel.text = MyVariables.timeStamp
    }
    
    
    //MARK: - tableView
    /***************************************************************/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coinCell = tableView.dequeueReusableCell(withIdentifier: "portfolioCell", for: indexPath) as! PortfolioCell
        
        coinCell.coinNameCell.text = MyVariables.dataArray[indexPath.row].coinNameCell
        coinCell.tickerCell.text = MyVariables.dataArray[indexPath.row].tickerCell
        coinCell.changeCell.text = ((MyVariables.dataArray[indexPath.row].changeCell).withSeparator)+" %"
        coinCell.priceCell.text = (MyVariables.dataArray[indexPath.row].priceCell*MyVariables.dataArray[indexPath.row].ownedCell).withSeparator
        
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
    
    
    //MARK: - editing
    /***************************************************************/
    
    func savesArray() {
        
        let defaults = UserDefaults.standard
        defaults.set(MyVariables.ownedArray, forKey: "SavedFloatArray")
//        print("SavedFloatArray")
//        print(MyVariables.ownedArray)
    }
    
    func portfolioButtonPressed(coinCell: PortfolioCell, editingChangedInTextCell newValue: String) {
        let indexPath = self.cellTableView.indexPathForRow(at: coinCell.center)!
        let selectedCell = cellTableView.cellForRow(at: indexPath) as! PortfolioCell
        
        selectedCell.priceCell.isHidden = false
        selectedCell.textCell.isHidden = true
        
//        print("editingChangedInTextField: \"\(newValue)\" in cell: \(indexPath.row)")
        
        if newValue != "XXX" {
            let owned: Float = Float(newValue)!
            MyVariables.dataArray[indexPath.row].ownedCell = owned
            MyVariables.ownedArray[indexPath.row] = Float(newValue)!
            
            savesArray()
        }

        selectedCell.priceCell.isHidden = false
        selectedCell.textCell.isHidden = true

        self.cellTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func portfolioButtonPressed(didSelect coinCell: PortfolioCell) {
        let indexPath = self.cellTableView.indexPathForRow(at: coinCell.center)!
        let selectedCell = cellTableView.cellForRow(at: indexPath) as! PortfolioCell

        selectedCell.priceCell.isHidden = true
        selectedCell.textCell.isHidden = false
        selectedCell.textCell.text = String(MyVariables.ownedArray[indexPath.row])
//        print(indexPath.row)
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

