//
//  mainTableViewController.swift
//  passwordLocker
//
//  Created by Kartheek chintalapati on 21/05/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class mainTableViewController: UITableViewController {

    var tableObject = [UandPList] () //object of the uandplist class
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readPropertyList() //calling the function
    }
    
    //This function finds the property list, read each dictionary entries in the plist array, initialize and append the object properties in the UandPList class.
    func readPropertyList()
    {
        let path = Bundle.main.path(forResource: "UandPList", ofType: "plist")
        let upListArray:NSArray = NSArray(contentsOfFile: path!)!
        
        for dict in upListArray
        {
            let username = (dict as! NSDictionary)["username"] as! String
            let password = (dict as! NSDictionary)["password"] as! String
            let website = (dict as! NSDictionary)["website"] as! String
            
            tableObject.append(UandPList(username : username, password : password, website : website))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableObject.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let cell:mainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CELL") as! mainTableViewCell
        let upList:UandPList = tableObject[indexPath.row]
        
        //place the attirbutes in the cell
        cell.usernameLabel.text = upList.username
        cell.passwordLabel.text = upList.password
        cell.websiteLabel.text = upList.website
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    */

}
