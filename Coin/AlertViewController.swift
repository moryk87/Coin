//
//  SecondViewController.swift
//  Coin
//
//  Created by Jan Moravek on 27/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AlertCellDelegate {
    
    var array = ["BTC","ETH"]
    let currencySwitcher = CurrencySwitcher ()
    var xyz = ""
    
    @IBOutlet weak var cellTableView: UITableView!    
    @IBOutlet weak var currencyControl: UISegmentedControl!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cellTableView.delegate = self
        cellTableView.dataSource = self
        
        cellTableView.register(UINib(nibName: "AlertCell", bundle: nil), forCellReuseIdentifier: "alertCell")
        
        self.currencyControl.selectedSegmentIndex = MyVariables.currencyControlSelected
        
        timeStampLabel.text = MyVariables.timeStamp
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.cellTableView.reloadData()
        self.currencyControl.selectedSegmentIndex = MyVariables.currencyControlSelected
        self.timeStampLabel.text = MyVariables.timeStamp

    }
    
    //MARK: - tableView
    /***************************************************************/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return array.count
        return MyVariables.coinTickerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coinCell = tableView.dequeueReusableCell(withIdentifier: "alertCell", for: indexPath) as! AlertCell

//        coinCell.tickerCell.text = array[indexPath.row]
        
        coinCell.coinNameCell.text = MyVariables.dataArray[indexPath.row].coinNameCell
        coinCell.tickerCell.text = MyVariables.dataArray[indexPath.row].tickerCell
        
        coinCell.delegate = self
        
        return coinCell
    }
    
    
    func alertButtonPressed(didSelect coinCell: AlertCell) {
        let indexPath = self.cellTableView.indexPathForRow(at: coinCell.center)!
        let selectedCell = cellTableView.cellForRow(at: indexPath) as! AlertCell
        
        xyz = selectedCell.coinNameCell.text!
        
        performSegue(withIdentifier: "editSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let destinationVC = segue.destination as! EditAlertViewController
            destinationVC.texttt = xyz
        }
    }
    
    
    //MARK: - IBAction
    /***************************************************************/
    
    @IBAction func currencyControlPressed(_ sender: UISegmentedControl) {
        
        currencySwitcher.switcher(sender: sender.selectedSegmentIndex)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addSegue", sender: self)
    }
    
}

