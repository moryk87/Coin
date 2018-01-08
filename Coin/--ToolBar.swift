////
////  ToolBar.swift
////  Coin
////
////  Created by Jan Moravek on 04/01/2018.
////  Copyright © 2018 Jan Moravek. All rights reserved.
////
//
//import UIKit
//
//class ToolBar: UIViewController, UITextFieldDelegate  {
//
//    var screenWidth: CGFloat {
//        return UIScreen.main.bounds.width
//    }
//
//    func bar (textFied: UITextField) {
//
//        let flexiableSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(PortfolioCell.doneButtonAction))
//        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 35))
//
//        toolBar.barTintColor = UIColor(red:0.15, green:0.69, blue:0.75, alpha:1.0)
//        toolBar.tintColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
//        toolBar.setItems([flexiableSpace, doneButton], animated: false)
//
//        textFied.inputAccessoryView = toolBar
//        textFied.keyboardType = UIKeyboardType.decimalPad
//    }
//
//    @objc func doneButtonAction(textFied: UITextField) {
//        textFied.endEditing(true)
//    }
//
//}
//
//
