//
//  SecondViewController.swift
//  Coin
//
//  Created by Jan Moravek on 27/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AlertCellDelegate, EditAlertDelegate {
    
    let currencySwitcher = CurrencySwitcher ()
//    let editAlertViewController = EditAlertViewController()

//    var selectedNotificationIndex: Int = 0
    
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
        return MyVariables.notificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coinCell = tableView.dequeueReusableCell(withIdentifier: "alertCell", for: indexPath) as! AlertCell
        let shortcut = MyVariables.notificationArray[indexPath.row]
        
        coinCell.coinNameCell.text = shortcut.coinNameCell
        coinCell.tickerCell.text = shortcut.tickerCell
        
        let myString: NSString = ("\(shortcut.conditionCell) \(shortcut.valueCell) \(shortcut.currencyCell)" as NSString)
        var myColorString = NSMutableAttributedString()
        myColorString = NSMutableAttributedString(string: myString as String)
        
        if shortcut.conditionCell == "gain" {
            myColorString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.00, green:0.63, blue:0.00, alpha:1.0), range: NSRange(location:5,length:4))
        } else if shortcut.conditionCell == "lose" {
            myColorString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red:0.87, green:0.23, blue:0.23, alpha:1.0), range: NSRange(location:5,length:4))
        }
        
        coinCell.textCell.attributedText = myColorString
        coinCell.delegate = self
        
        return coinCell
    }
    
    //MARK: - alertButtonPressed
    /***************************************************************/
    
    func editButtonPressed(didSelect coinCell: AlertCell) {
        let indexPath = self.cellTableView.indexPathForRow(at: coinCell.center)!
//        let selectedCell = cellTableView.cellForRow(at: indexPath) as! AlertCell
        
        MyVariables.selectedNotificationIndex = indexPath.row
        print(MyVariables.selectedNotificationIndex)
        
        performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetVC = destinationNavigationController.topViewController as! EditAlertViewController

            let shortcut = MyVariables.notificationArray[MyVariables.selectedNotificationIndex]

            print(shortcut.coinNameCell)

//            targetVC.coinNameField.text = shortcut.coinNameCell
//            targetVC.tickerField.text = shortcut.tickerCell
//            targetVC.conditionField.text = shortcut.conditionCell
//            targetVC.valueField.text = String(shortcut.valueCell)
//            targetVC.currencyField.text = shortcut.currencyCell

            MyVariables.deleteHidden = false
            MyVariables.edit = true
            targetVC.delegate = self
        }
        else {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetVC = destinationNavigationController.topViewController as! EditAlertViewController
            MyVariables.deleteHidden = true
            MyVariables.edit = false
            targetVC.delegate = self
        }
    }
    
    //MARK: - alertButtonPressed
    /***************************************************************/
    
    func editAlertButtonPressed(didPress: Bool) {
        guard didPress else {
            // Handle the unfinished state
            return
        }
        self.cellTableView.reloadData()
        print("reloadData")
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

