//
//  EditAlertViewController.swift
//  Coin
//
//  Created by Jan Moravek on 03/01/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit

protocol EditAlertDelegate {
    func editAlertButtonPressed(didPress: Bool)
//    func alertSaveButtonPressed(coinCell:PortfolioCell, editingChangedInTextCell newValue:String)
}

class EditAlertViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var delegate: EditAlertDelegate?
    let currencySwitcher = CurrencySwitcher ()
//    let toolBar = ToolBar ()
    
    @IBOutlet weak var coinNamePicker: UIPickerView!
    @IBOutlet weak var conditionPicker: UIPickerView!
    @IBOutlet weak var valueTextField: UITextField!
    
    @IBOutlet weak var currencyControl: UISegmentedControl!
    
    @IBOutlet weak var coinNameField: UILabel!
    @IBOutlet weak var tickerField: UILabel!
    @IBOutlet weak var conditionField: UILabel!
    @IBOutlet weak var valueField: UILabel!
    @IBOutlet weak var currencyField: UILabel!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
//        self.navigationController?.navigationBar.topItem?.title = "Back"
        
        valueTextField.delegate = self
        
        coinNamePicker.dataSource = self
        coinNamePicker.delegate = self
        
        conditionPicker.dataSource = self
        conditionPicker.delegate = self
        
        deleteButton.isHidden = MyVariables.deleteHidden
        
        toolBar ()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if MyVariables.edit == true {
            let shortcut = MyVariables.notificationArray[MyVariables.selectedNotificationIndex]
            print(shortcut.coinNameCell)
            
            coinNameField.text = shortcut.coinNameCell
            tickerField.text = shortcut.tickerCell
            conditionField.text = shortcut.conditionCell
            valueField.text = String(shortcut.valueCell)
            currencyField.text = shortcut.currencyCell
        }
    }
    
    //MARK: - toolBar
    /***************************************************************/
    
    func toolBar () {
        
        let flexiableSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneButtonAction))
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        
        toolBar.barTintColor = UIColor(red:0.15, green:0.69, blue:0.75, alpha:1.0)
        toolBar.tintColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        toolBar.setItems([flexiableSpace, doneButton], animated: false)
        
        valueTextField.inputAccessoryView = toolBar
        valueTextField.keyboardType = UIKeyboardType.decimalPad
    }
    
    @objc func doneButtonAction() {
        valueTextField.endEditing(true)
    }
    
    
    //MARK: - pickerView
    /***************************************************************/
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == coinNamePicker {
            return MyVariables.coinNameArray.count
        } else {
            return MyVariables.conditionArray.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == coinNamePicker {
            return MyVariables.coinNameArray[row]
        } else {
            return MyVariables.conditionArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == coinNamePicker {
            coinNameField.text = MyVariables.coinNameArray[row]
            tickerField.text = MyVariables.coinTickerArray[row]
        } else {
            conditionField.text = MyVariables.conditionArray[row]
            valueTextField.becomeFirstResponder()
            if row >= 1 {
                currencyField.text = "%"
            }
        }
    }
    
    //MARK: - IBAction
    /***************************************************************/
    
    @IBAction func currencyControlPressed(_ sender: UISegmentedControl) {
        currencySwitcher.switcher(sender: sender.selectedSegmentIndex)
        currencyField.text = MyVariables.currencyShortcutArray[sender.selectedSegmentIndex]
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        if MyVariables.edit == true {
            let shortcut = MyVariables.notificationArray[MyVariables.selectedNotificationIndex]
            
            shortcut.coinNameCell = coinNameField.text!
            shortcut.tickerCell = tickerField.text!
            shortcut.conditionCell = conditionField.text!
            shortcut.valueCell = Float(valueField.text!)!
            shortcut.currencyCell = currencyField.text!
            
        } else  {
            MyVariables.notificationArray.append(
                NotificationLabel(coinNameCell: coinNameField.text!, tickerCell: tickerField.text!, conditionCell: conditionField.text!, valueCell: Float(valueField.text!)!, currencyCell: currencyField.text!)
            )
        }
        
        print(MyVariables.notificationArray[MyVariables.selectedNotificationIndex].coinNameCell)
        print(MyVariables.notificationArray[MyVariables.selectedNotificationIndex].conditionCell)
        print(MyVariables.notificationArray[MyVariables.selectedNotificationIndex].valueCell)
        print(MyVariables.notificationArray[MyVariables.selectedNotificationIndex].currencyCell)
        
        self.delegate?.editAlertButtonPressed(didPress: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {

        MyVariables.notificationArray.remove(at: MyVariables.selectedNotificationIndex)
        self.delegate?.editAlertButtonPressed(didPress: true)
        self.dismiss(animated: true, completion: nil)
        
        print("delete")
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        if (sender.text?.isEmpty)! {
            valueField.text = "0"
        } else {
            valueField.text = sender.text
        }
    }
    
    
}
