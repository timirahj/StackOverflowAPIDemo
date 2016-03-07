//
//  ViewController.swift
//  StackOverflow-API-Demo
//
//  Created by Timirah James on 2/23/16.
//  Copyright © 2016 Timirah James. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var users: [String]? = []
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    
    
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        
        let url = "https://api.stackexchange.com/2.2/users?site=stackoverflow"
        
        // This makes the GET call to stackoverflow.com. It simply gets the users info and
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in

            if let JSON = response.result.value {
                
                let items = JSON["items"] as? NSArray
                
                print(JSON)
                    
       // cell.repLabel?.text = items?.objectAtIndex(indexPath.row).objectForKey("reputation") as? String?.toInt()
        cell.nameLabel?.text = items?.objectAtIndex(indexPath.row).objectForKey("display_name") as? String
        cell.locationLabel?.text = items?.objectAtIndex(indexPath.row).objectForKey("location") as? String
                
            }
            
        }
        
        return cell
        
    }
    


}
