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
    
    var otherArray = ["some", "things", "keep", "moving"]
    
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
        
        let url = "https://api.stackexchange.com/2.2/users?site=stackoverflow"
        
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            
         /*   if json != nil {
                var jsonObj = JSON(json!)
                if let data = jsonObj["data"].arrayValue as [JSON]?{
                    self.datas = data
                    self.tableView.reloadData()*/
        
            if let JSON = response.result.value {
                
                let items = JSON["items"] as? NSArray
                
                
                print(items?.objectAtIndex(0).objectForKey("display_name") as? String)
                
              //  let items = (JSON.valueForKey("items") as! NSArray)
                
                //for item in JSON{
                    
                   // var user: User = User()
                    
                  //  if let items = JSON["items"] as? NSArray {
                 //   user.location = items["display_name"] as? String
                    
                   // self.users?.append(user.name)
                    
                 //   print(user.name)
                    
                }
            }
                   // print(JSON["items"])
                
                //self.myArray?.append(JSON[])
                
               // print(self.myArray)
                        
                   // }
                    //print("Dani's age is \(age)")
        }
  //  }
    
    
                   // return
              //  }
                
              //  self.json = JSON(data)
                //self.tableView.reloadData()
                
     //   }

                
             /*   if (json != nil){
                    
                    var jsonObj = json
                    
                    if let data = jsonObj["items"].arrayValue as []?{
                        self.myArray = data
                        self.tableView.reloadData()
                        
                        print(json)
                        print(error)
                        
                    }
                    
                    
            }*/

                //self.name = json["display_name"].stringValue
                
           //     print("THIS IS YOUR NAME: \(json[0].stringValue)")
                
          //  }
        //name = json["name"].stringValue
///
  // }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return otherArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        
        let url = "https://api.stackexchange.com/2.2/users?site=stackoverflow"
        
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in

            if let JSON = response.result.value {
                
                let items = JSON["items"] as? NSArray
                
                print(JSON)
                    
        cell.repLabel?.text = items?.objectAtIndex(indexPath.row).objectForKey("reputation") as? String?.toInt()
        cell.nameLabel?.text = items?.objectAtIndex(indexPath.row).objectForKey("display_name") as? String
        cell.locationLabel?.text = items?.objectAtIndex(indexPath.row).objectForKey("location") as? String
                
            }
            
        }
        
        return cell
        
        
    }
    


}
