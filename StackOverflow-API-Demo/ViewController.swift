//
//  ViewController.swift
//  StackOverflow-API-Demo
//
//  Created by Timirah James on 2/23/16.
//  Copyright © 2016 Timirah James. All rights reserved.
//

import UIKit
//import Alamofire
import Alamofire
import Alamofire_SwiftyJSON
//import Alamofire_SwiftyJSON



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var myArray = ["hello", "bye", "what", "ever."]
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getStuff()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    
    
    //MARK: - REST calls
    // This makes the GET call to stackoverflow.com. It simply gets the users info and .
    func getStuff() {
        
       Alamofire.request(.GET, "https://api.stackexchange.com/2.2/users?site=stackoverflow", parameters: ["foo": "bar"])
            .responseSwiftyJSON({ (request, response, json, error) in
                print(json)
                print(error)
                
                //self.name = json["display_name"].stringValue
                
                print("THIS IS YOUR NAME: \(json["display_name"].stringValue)")
                
            })
        //name = json["name"].stringValue
///
   }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        
        //cell.middleLabel.text = items[indexPath.row]
        cell.nameLabel?.text = name
        //cell.rightLabel.text = items[indexPath.row]
        
        return cell
        
    }
    


}
