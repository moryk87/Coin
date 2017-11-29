//
//  FirstViewController.swift
//  Coin
//
//  Created by Jan Moravek on 27/11/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //1
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var currencySwitchControl: UISegmentedControl!
    @IBOutlet weak var cellTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2
        cellTableView.delegate = self
        cellTableView.dataSource = self
        
        //4
        cellTableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "customCell")
        
    }
    
    //3
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let coinCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
        let coinArray = ["Bitcoin", "Ethereum", "XEM"]
        
        coinCell.coinNameCell.text = coinArray[indexPath.row]
        
        return coinCell
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    
    
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
    }

    @IBAction func currencySwitchControlPressed(_ sender: UISegmentedControl) {
    }
    
    
}

