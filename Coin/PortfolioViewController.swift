//
//  SecondViewController.swift
//  Coin
//
//  Created by Jan Moravek on 27/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PortfolioCellDelegate {
    
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
        
        getData.delegate = self
        
        timeStampLabel.text = MyVariables.timeStamp
    
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cellTableView.reloadData()
        self.currencyControl.selectedSegmentIndex = MyVariables.currencyControlSelected
        self.timeStampLabel.text = MyVariables.timeStamp
        
        print("MyVariables.ownedArray:")
        print(MyVariables.ownedArray)
        
//        savesArray()
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
    

    
    
    
//    if let temp = UserDefaults.standardUserDefaults.objectForKey("myArray") as? [Int] {
//        myArray = temp
//    }
//
//
//    if let myLoadedArray = UserDefaults.standard.array(forKey: "myArray") as? [Int] {
//        print(myLoadedArray)
//    }
    
//    Or use the nil coalescing operator ??:
    
//    let myLoadedArray = UserDefaults.standard.array(forKey: "SavedIntArray") as? [Int] ?? []
//
//    let LoadedArray : [Int] = UserDefaults.standard.array(forKey: "SavedIntArray") as! [Int]
    
    
    //MARK: - editing
    /***************************************************************/
    
    func savesArray() {
        
        let defaults = UserDefaults.standard
        defaults.set(MyVariables.ownedArray, forKey: "SavedFloatArray")
        print("SavedFloatArray")
        print(MyVariables.ownedArray)
        
    }
    
    func portfolioButtonPressed(coinCell: PortfolioCell, editingChangedInTextCell newValue: String) {
        let indexPath = self.cellTableView.indexPathForRow(at: coinCell.center)!
        let selectedCell = cellTableView.cellForRow(at: indexPath) as! PortfolioCell
        
        selectedCell.priceCell.isHidden = false
        selectedCell.textCell.isHidden = true
        
//        selectedCell.textCell.delegate = self
        
        print("editingChangedInTextField: \"\(newValue)\" in cell: \(indexPath.row)")
        
        if newValue != "XXX" {
            let owned: Float = Float(newValue)!
            MyVariables.dataArray[indexPath.row].ownedCell = owned
            MyVariables.ownedArray[indexPath.row] = Float(newValue)!
            
            savesArray()
        }

        
        
//            if owned >= 0 {
//                MyVariables.dataArray[indexPath.row].ownedCell = owned
//            } else {
//                MyVariables.dataArray[indexPath.row].ownedCell = 0.00
//            }
        
//            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//                selectedCell.textCell.resignFirstResponder()
//                print("return textFieldShouldReturn")
//                return true
//            }
        
        selectedCell.priceCell.isHidden = false
        selectedCell.textCell.isHidden = true

//        self.cellTableView.reloadData()
        self.cellTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func portfolioButtonPressed(didSelect coinCell: PortfolioCell) {
        let indexPath = self.cellTableView.indexPathForRow(at: coinCell.center)!
        let selectedCell = cellTableView.cellForRow(at: indexPath) as! PortfolioCell

        selectedCell.priceCell.isHidden = true
        selectedCell.textCell.isHidden = false
        selectedCell.textCell.text = String(MyVariables.ownedArray[indexPath.row])
//        selectedCell.textCell.keyboardType = UIKeyboardType.decimalPad
        
        print(indexPath.row)
        
        
//        print("coinCell: \(coinCell)")
//        print("coinCell.cente: \(coinCell.center)")
        
//        func textFieldShouldBeginEditing(textField: UITextField) {
//            print("textFieldShouldBeginEditing")
//            selectedCell.textCell.becomeFirstResponder()
//        }
//
//        func textFieldShouldEndEditing(textField: UITextField)  -> Bool {
//            print("textFieldShouldEndEditing")
//            selectedCell.textCell.resignFirstResponder()
//            return true
        
        }
//        func textFieldDidBeginEditing(textField: UITextField) {
//            selectedCell.textCell.becomeFirstResponder()
//            print("textFieldDidBeginEditing")
//        }
//
//        func textFieldDidEndEditing(textField: UITextField) {
//            print(String(describing: textField.text))
//
//        }
//
//        func textFieldShouldReturn(textField: UITextField) -> Bool {
//            selectedCell.textCell.resignFirstResponder()
//            print("return textFieldShouldReturn")
//            return true
//        }
//
//        func textFieldShouldEndEditing(textField: UITextField) {
//            selectedCell.textCell.resignFirstResponder()
//            print("return textFieldShouldEndEditing")
//        }
    
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let indexPath = self.cellTableView.indexPathForRow(at: indexPath)!
//        let selectedCell = cellTableView.cellForRow(at: indexPath) as! PortfolioCell
//        print("selected")
//        print(indexPath.row)
//        print(" ")
//
//        selectedCell.priceCell.isHidden = true
//        selectedCell.textCell.isHidden = false
//
//        selectedCell.textCell.delegate = self
//        //selectedCell.textCell.keyboardType = UIKeyboardType.decimalPad
//
////        func textFieldShouldReturn(textField: UITextField) -> Bool {
////            selectedCell.textCell.resignFirstResponder()
////            print("return")
////            return true
////        }
//
//
//
//    }

//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let selectedCell = cellTableView.cellForRow(at: indexPath) as! PortfolioCell
//        print("deslected")
//        print(indexPath.row)
//
//        selectedCell.priceCell.isHidden = false
//        selectedCell.textCell.isHidden = true
//
//        self.cellTableView.reloadData()
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        print("return")
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let editAction = UITableViewRowAction(style: .default,title: "Edit") {
//            (action, index) in
//            print("edit")
//        }
//
//        return [editAction]
//    }
    
    
    
    
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

