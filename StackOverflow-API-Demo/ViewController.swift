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
    
    var userInfo = [[String:AnyObject]]()//Array of dictionary

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "blur-background.jpg")
        backgroundImage.frame = self.view.bounds
        
        self.view.addSubview(backgroundImage)
        
        tableView.reloadData()
        
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
        
        cell.backgroundColor = UIColor.clearColor()
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
         self.performSegueWithIdentifier("showBadges", sender: indexPath)
        
    }

}
