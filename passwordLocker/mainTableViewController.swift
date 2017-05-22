//
//  mainTableViewController.swift
//  passwordLocker
//
//  Created by Kartheek chintalapati on 21/05/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class mainTableViewController: UITableViewController, UISearchBarDelegate {

    //MARK: connections
    @IBOutlet var searchTableView: UITableView! //table view
    
    //MARK: Variables
    var tableObject = [UandPList] () //object of the uandplist class
    var filteredObject = [UandPList] () //object to hold filtered results
    
    //This is to let the controller know that I am using the same View Controller to show the search results.
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        readPropertyList() //calling the function
        
        //MARK: Search bar related
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating       //This will let the class be informed of any text changes in the search bar
        searchController.dimsBackgroundDuringPresentation = false   //This will not let the view controller get dim when a search is performed.
        definesPresentationContext = true   //this will make sure that the search bar will not be active in other screens
        tableView.tableHeaderView = searchController.searchBar  //This will add the search bar to table header view
        
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

    //This function returns the filtered data
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredObject = tableObject.filter { item in
            return item.website.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
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
        //This will show the search results if the search bar is active and something is typed into it or displays all the cells if no search is performed.
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredObject.count
        }
        return tableObject.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        let cell:mainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CELL") as! mainTableViewCell
        let upList:UandPList
        
        //Determine which list to show based on search bar activity
        if searchController.isActive && searchController.searchBar.text != "" {
            upList = filteredObject[indexPath.row]
        }
        else {
            upList = tableObject[indexPath.row]
        }
        
        //place the attirbutes in the cell
        cell.usernameLabel.text = upList.username
        cell.passwordLabel.text = upList.password
        cell.websiteLabel.text = upList.website
        
        return cell
    }
    
    //MARK: Delegate Methods
    
    //This function dismisses the keyboard when tapped outside the field
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    //This function dismisses the keyboard when the user presses the return key
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchController.resignFirstResponder()
        
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    */

}

// This class extension allows the table view controller to respond to search bar by implementing UISearchResultsUpdating.
extension mainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
