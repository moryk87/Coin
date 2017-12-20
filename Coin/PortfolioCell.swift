//
//  SecondCell.swift
//  Coin
//
//  Created by Jan Moravek on 13/12/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit

protocol PortfolioCellDelegate {
    func portfolioButtonPressed(coinCell: PortfolioCell)
}

class PortfolioCell: UITableViewCell {
    
    var delegate: PortfolioCellDelegate?

    @IBOutlet weak var coinNameCell: UILabel!
    @IBOutlet weak var tickerCell: UILabel!
    @IBOutlet weak var changeCell: UILabel!
    @IBOutlet weak var priceCell: UILabel!
    @IBOutlet weak var textCell: UITextField!
    @IBOutlet weak var editCell: UIButton!
    
    @IBAction func editCellPressed(_ sender: UIButton) {
        delegate?.portfolioButtonPressed(coinCell: self)
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
