//
//  ViewController.swift
//  StackOverflow-API-Demo
//
//  Created by Timirah James on 2/23/16.
//  Copyright © 2016 Timirah James. All rights reserved.
//

import UIKit
import Alamofire
import ImageLoader


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
    var users: [String]? = []
    
    //Array of dictionary
    var userInfo = [[String:AnyObject]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.reloadData()
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        
        //
        let url = "https://api.stackexchange.com/2.2/users?site=stackoverflow"
        
        // This makes the GET call to stackoverflow.com. It simply gets the users info and
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            
            let JSON = response.result.value
                
            if let items = JSON!["items"] as? NSArray {
                self.userInfo = items as! [[String: AnyObject]]
                
            }
            
                print(JSON)
            
            if self.userInfo.count > 0 {
              
                self.tableView.reloadData()
            
            }
            
        }
        
    }
    
    
   override func viewWillAppear(animated: Bool) {
    
    let backgroundImage = UIImage(named: "SO.png")
    let imageView = UIImageView(image: backgroundImage)
    imageView.contentMode = .ScaleAspectFit
    self.tableView.backgroundColor = UIColor.orangeColor()
    
    self.tableView.backgroundView = imageView
    
    self.tableView.separatorColor = UIColor.blackColor()
    
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
        
        return userInfo.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        
        var dict = userInfo[indexPath.row]
                
                let rep = dict["reputation"]!.intValue
                let name = dict["display_name"] as? String
                let location = dict["location"] as? String
                let imageString = dict["profile_image"] as? String
                
        cell.repLabel?.text = "Reputation: \(rep)"
        cell.nameLabel?.text = name
        cell.locationLabel?.text = location
        cell.profileImage.load(imageString!)
        
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        
        if (location == nil){
            
             cell.locationLabel?.text = "Location Unknown"
        }
        
        cell.profileImage.layer.cornerRadius = 3
        cell.profileImage.layer.borderWidth = 3
        cell.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        cell.backgroundColor = UIColor(white: 1, alpha: 0.6)
        
        return cell
    }

}
