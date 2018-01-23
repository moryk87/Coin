//
//  AlertViewController.swift
//  Coin
//
//  Created by Jan Moravek on 18/12/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit
import Firebase

class AlertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AlertCellDelegate, EditAlertDelegate {
    
    let currencySwitcher = CurrencySwitcher ()
    let notification = Notification ()
    var myDatabase: DatabaseReference?
    
    @IBOutlet weak var cellTableView: UITableView!    
    @IBOutlet weak var currencyControl: UISegmentedControl!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellTableView.delegate = self
        cellTableView.dataSource = self
        
        cellTableView.tableFooterView = UIView()
        
        cellTableView.register(UINib(nibName: "AlertCell", bundle: nil), forCellReuseIdentifier: "alertCell")
        
        self.currencyControl.selectedSegmentIndex = MyVariables.currencyControlSelected
        
        timeStampLabel.text = MyVariables.timeStamp
        
        logIn()
        retrieveNotificationArray()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cellTableView.reloadData()
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
    
    //MARK: - editButtonPressed
    /***************************************************************/
    
    func editButtonPressed(didSelect coinCell: AlertCell) {
        let indexPath = self.cellTableView.indexPathForRow(at: coinCell.center)!
        
        MyVariables.selectedNotificationIndex = indexPath.row
//        print(MyVariables.selectedNotificationIndex)
        
        performSegue(withIdentifier: "editSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetVC = destinationNavigationController.topViewController as! EditAlertViewController

            let shortcut = MyVariables.notificationArray[MyVariables.selectedNotificationIndex]

            print(shortcut.coinNameCell)

            MyVariables.deleteHidden = false
            MyVariables.edit = true
            targetVC.delegate = self
            
//            print("EDIT")
//            print(MyVariables.selectedNotificationIndex)
        }
        else {
            let destinationNavigationController = segue.destination as! UINavigationController
            let targetVC = destinationNavigationController.topViewController as! EditAlertViewController
            MyVariables.deleteHidden = true
            MyVariables.edit = false
            targetVC.delegate = self
            
            if MyVariables.selectedNotificationIndex != 0 {
                MyVariables.selectedNotificationIndex = MyVariables.notificationArray.count
            }
            
//            print("NEW")
//            print(MyVariables.selectedNotificationIndex)
        }
    }
    
    
    //MARK: - retrieve data
    /***************************************************************/
    
    func retrieveNotificationArray () {
        myDatabase = Database.database().reference().child("notificationArray")
        
        myDatabase?.observe(.childAdded, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            
            MyVariables.notificationArray.append(
                NotificationLabel(coinNameCell: snapshotValue["coinNameCell"]!, tickerCell: snapshotValue["tickerCell"]!, conditionCell: snapshotValue["conditionCell"]!, valueCell: Float(snapshotValue["valueCell"]!)!, currencyCell: snapshotValue["currencyCell"]!, keyCell: snapshot.key)
            )
//            print(snapshot.key)
            
            MyVariables.selectedNotificationIndex = MyVariables.notificationArray.count - 1
            self.cellTableView.reloadData()
        })
    }
    
    func logIn () {
        
        Auth.auth().signInAnonymously { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("login succesful")
            }
        }
    }
    
    //MARK: - save data
    /***************************************************************/
    
    func saveNotificationArray () {
        
        myDatabase = Database.database().reference()
        let shortcut = MyVariables.notificationArray[MyVariables.selectedNotificationIndex]
        let notificationDictionary = ["coinNameCell": shortcut.coinNameCell,
                                      "tickerCell": shortcut.tickerCell,
                                      "conditionCell": shortcut.conditionCell,
                                      "valueCell": String(shortcut.valueCell),
                                      "currencyCell": shortcut.currencyCell
        ]
        
        if MyVariables.edit == true {

            myDatabase?.child("notificationArray").child(shortcut.keyCell).updateChildValues(notificationDictionary)
            {
                (error, reference) in
                
                if error != nil {
                    print(error!)
                } else {
//                    print("EDITED saved successfully")
//                    print("\(shortcut.keyCell)")
                }
            }
            
        } else {
            
            myDatabase?.child("notificationArray").childByAutoId().setValue(notificationDictionary) {
                (error, reference) in
                
                if error != nil {
                    print(error!)
                } else {
//                    print("NEW saved successfully")
//                    print(MyVariables.selectedNotificationIndex)
                    
                    let shortcut = MyVariables.notificationArray[MyVariables.selectedNotificationIndex]
                    
                    self.notification.sendPush(coinNameCell: shortcut.coinNameCell, tickerCell: shortcut.tickerCell, conditionCell: shortcut.conditionCell, valueCell: shortcut.valueCell, currencyCell: shortcut.currencyCell)
                }
            }
            MyVariables.notificationArray.remove(at: MyVariables.selectedNotificationIndex)
        }
        
        self.cellTableView.reloadData()
//        print("reloadData")
    }
    
    
    //MARK: - alertButtonPressed
    /***************************************************************/
    
    func editAlertButtonPressed(didPress: Bool) {
//        guard didPress else {
//            // Handle the unfinished state
//            return
//        }
        
        saveNotificationArray ()
//        print(MyVariables.notificationArray.count)
    }
    
    func deleteAlertButtonPressed(didPress: Bool) {
        
        myDatabase = Database.database().reference()
        let shortcut = MyVariables.notificationArray[MyVariables.selectedNotificationIndex]
//        print(MyVariables.selectedNotificationIndex)
        
        myDatabase?.child("notificationArray").child(shortcut.keyCell).removeValue(completionBlock: { (error, refererence) in
            if error != nil {
                print(error!)
            } else {
                print(refererence)
                print("Child Removed Correctly")
            }
        })
        MyVariables.notificationArray.remove(at: MyVariables.selectedNotificationIndex)
        self.cellTableView.reloadData()
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
