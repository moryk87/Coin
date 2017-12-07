//
//  aa.swift
//  Coin
//
//  Created by Jan Moravek on 07/12/2017.
//  Copyright © 2017 Jan Moravek. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class MenuView: UIViewController, KYDrawerControllerDelegate,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTableview: UITableView!
    
    struct Objects {
        var sectionName : String!
        var sectionObjects : [String]!
    }
    
    var objectsArray = [Objects]()
    var categoriesArr =  [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        //self.title = "Home Screen"
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.alpha = 0.0
        
        objectsArray = [
            Objects(sectionName: "", sectionObjects: ["Home"]),
            Objects(sectionName: "Categories", sectionObjects: categoriesArr),
            Objects(sectionName: "My Account", sectionObjects: ["My WishList", "My Profile", "My Addresses", "My Order", "Log out"]),
            Objects(sectionName: "Support", sectionObjects: ["About Us", "Delivery Information", "Privacy Policy", "Terms & Conditions", "Contact Us", "Return Policy"])]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        callAPI()
    }
    //MARK: UITabView DataSources
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell!
        
        
        cell.textLabel?.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].sectionObjects.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return objectsArray.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }
    
    func callAPI () {
        Alamofire.request(.POST, "http://www.picknget.com/webservice/index.php/Home/get_all_category")
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    if let _statusCode = json["status"].string {
                        print("the ststus code is ", _statusCode)
                        if (_statusCode == "1"){
                            self.parseJSON(json)
                        }
                        else {
                            self.callAlert("Alert", _msg: "Something Went Wrong Kindly Check Your Connection & Try Agian")
                        }
                    }
                    //print ("json result ", json)
                    
                }
            }.responseString { response in
                //print("response ",response.result.value)
        }
    }
    
    
    func parseJSON(json: JSON) {
        
        for result in json["category"].arrayValue {
            print("The available categories are",result["MainCatName"].stringValue)
            self.categoriesArr.append(result["MainCatName"].stringValue)
        }
        
        print("@@@@@@@@")
        objectsArray[2].sectionObjects = categoriesArr
        print(categoriesArr.count)
        
        print(categoriesArr[0],categoriesArr[1])
        dispatch_async(dispatch_get_main_queue(),{
            self.menuTableview.reloadData()
        });
}
