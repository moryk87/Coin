//
//  extension.swift
//  Coin
//
//  Created by Jan Moravek on 12/12/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import Foundation

extension Double {
    var withSeparator:String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "\u{2009}"
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter.string(from: self as NSNumber)!
    }
}
