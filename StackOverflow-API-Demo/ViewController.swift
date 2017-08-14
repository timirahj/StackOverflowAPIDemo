//
//  ViewController.swift
//  StackOverflow-API-Demo
//
//  Created by Timirah James on 2/23/16.
//  Copyright © 2016 Timirah James. All rights reserved.
//

import UIKit
import Alamofire
import KFSwiftImageLoader


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    
    //Array of dictionary
    var userInfo = [[String:AnyObject]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        tableView.reloadData()
        
        // Let's give our navigation bar a nice white blend
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        // Our URL in which we'll be getting our data from
        let url = "https://api.stackexchange.com/2.2/users?site=stackoverflow"
        
        // This makes the GET call to our URL. Here, we get the all users' info
        Alamofire.request(url).responseJSON { response in
           
        
            // typecast an array of the 'items' value as an array of dictionaries
             if let JSON = response.result.value as? [String: Any], let items = JSON["items"] as? [[String: AnyObject]] {
            
            self.userInfo = items
                
                print(JSON)
            }
        
            
            if self.userInfo.count > 0 {
              
                self.tableView.reloadData()
            
            }
            
        }
        
    }
    
    
   
   /*
    - Set the background image for the tableView
    */
   override func viewWillAppear(_ animated: Bool) {
    
    let backgroundImage = UIImage(named: "SO.png")
    let imageView = UIImageView(image: backgroundImage)
    imageView.contentMode = .scaleAspectFit
    self.tableView.backgroundColor = UIColor.orange
    
    self.tableView.backgroundView = imageView
    
    self.tableView.separatorColor = UIColor.black
    
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        
        var dict = userInfo[indexPath.row]
                
                let rep = dict["reputation"]!.int32Value
                let name = dict["display_name"] as? String
                let location = dict["location"] as? String
                let imageString = dict["profile_image"] as? String
                
        cell.repLabel?.text = "Reputation: \(rep!)"
        cell.nameLabel?.text = name
        cell.locationLabel?.text = location
        
        // Load the user's profile image using KFSwiftImageLoader's 'loadImage' function
        cell.profileImage.loadImage(urlString: imageString!)
        
        // make sure the edges of the separator are end to end
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        // if the location of the user is nil, set placeholder text for the locationLabel
        if (location == nil){
            
             cell.locationLabel?.text = "Location Unknown"
        }
        
        // create a white round border around the user's profile image
        cell.profileImage.layer.cornerRadius = 3
        cell.profileImage.layer.borderWidth = 3
        cell.profileImage.layer.borderColor = UIColor.white.cgColor
        
        // Let's make our cells transparent
        cell.backgroundColor = UIColor(white: 1, alpha: 0.6)
        
        return cell
    }

}
