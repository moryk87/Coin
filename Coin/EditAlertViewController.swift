//
//  EditAlertViewController.swift
//  Coin
//
//  Created by Jan Moravek on 03/01/2018.
//  Copyright © 2018 Jan Moravek. All rights reserved.
//

import UIKit

class EditAlertViewController: UIViewController {
    
    var texttt: String?
    
    @IBOutlet weak var label: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = texttt

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
