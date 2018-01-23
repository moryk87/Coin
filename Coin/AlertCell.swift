//
//  AlertCell.swift
//  Coin
//
//  Created by Jan Moravek on 30/12/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit

protocol AlertCellDelegate {
    func editButtonPressed(didSelect coinCell: AlertCell)
}

class AlertCell: UITableViewCell {
    
    var delegate: AlertCellDelegate?

    @IBOutlet weak var coinNameCell: UILabel!
    @IBOutlet weak var tickerCell: UILabel!
    @IBOutlet weak var textCell: UILabel!
    @IBOutlet weak var editCell: UIButton!
    
    @IBAction func editCellPressed(_ sender: UIButton) {
        delegate?.editButtonPressed(didSelect: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
