//
//  SecondCell.swift
//  Coin
//
//  Created by Jan Moravek on 13/12/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit

protocol PortfolioCellDelegate {
    func portfolioButtonPressed(didSelect coinCell: PortfolioCell)
    func portfolioButtonPressed(coinCell:PortfolioCell, editingChangedInTextCell newValue:String)
}

class PortfolioCell: UITableViewCell, UITextFieldDelegate  {
    
    var delegate: PortfolioCellDelegate?

    @IBOutlet weak var coinNameCell: UILabel!
    @IBOutlet weak var tickerCell: UILabel!
    @IBOutlet weak var changeCell: UILabel!
    @IBOutlet weak var priceCell: UILabel!
    @IBOutlet weak var textCell: UITextField!
    @IBOutlet weak var editCell: UIButton!
    
    @IBAction func editCellPressed(_ sender: UIButton) {
        textCell.becomeFirstResponder()
        delegate?.portfolioButtonPressed(didSelect: self)
    }
    
    @IBAction func textCellValueChanged(_ sender: UITextField) {

        if (sender.text?.isEmpty)! {
            delegate?.portfolioButtonPressed(coinCell: self, editingChangedInTextCell: "XXX")
        } else {
            let text = sender.text
            delegate?.portfolioButtonPressed(coinCell: self, editingChangedInTextCell: text!)
        }
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textCell.resignFirstResponder()
//        print("return textFieldShouldReturn")
//        return true
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textCell.delegate = self
        
        let flexiableSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneButtonAction))
        let toolBar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 35))

        toolBar.barTintColor = UIColor(red:0.15, green:0.69, blue:0.75, alpha:1.0)
        toolBar.tintColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        toolBar.setItems([flexiableSpace, doneButton], animated: false)

        textCell.inputAccessoryView = toolBar
        textCell.keyboardType = UIKeyboardType.decimalPad
    }

    @objc func doneButtonAction() {
        textCell.endEditing(true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
