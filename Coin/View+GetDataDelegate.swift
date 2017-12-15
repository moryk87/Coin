//
//  HomeView+GetData.swift
//  Coin
//
//  Created by Jan Moravek on 14/12/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import Foundation

extension HomeViewController: GetDataDelegate {
    func didFinishGetData(finished: Bool) {
        guard finished else {
            // Handle the unfinished state
            return
        }
        self.cellTableView.reloadData()
    }
}

//extension HomeViewController: GetDataDelegate {
//    func didFinishGetData(sender: GetData) {
//        DispatchQueue.main.async {
//            self.cellTableView.reloadData()
//        }
//    }
//}

extension PortfolioViewController: GetDataDelegate {
    func didFinishGetData(finished: Bool) {
        guard finished else {
            // Handle the unfinished state
            return
        }
        self.cellTableView.reloadData()
    }
}

