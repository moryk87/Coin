//
//  TableViewCell1.swift
//  Coin
//
//  Created by Jan Moravek on 29/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var coinNameCell: UILabel!
    @IBOutlet weak var tickerCell: UILabel!
    @IBOutlet weak var changeCell: UILabel!
    @IBOutlet weak var priceCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
}
