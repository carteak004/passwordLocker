//
//  mainTableViewController.swift
//  passwordLocker
//
//  Created by Kartheek chintalapati on 21/05/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/****************************************************************
 COMMIT HISTORY:
 commit 1: initial commit
 commit 2: main view that shows username, password and website from a plist
 commit 3: added search functionality to this view that refines results based on the name of the website.
 commit 4: changed the data source from plist to json and deleted plist. change in data source is done to fetch live data that can be updated at any point of time.
 commit 5: changed the url for fetching json data, added sno in articles fetch block.
 ****************************************************************/

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
        
        fetchJsonData() //calling the function to fetch data from json file
        
        //MARK: Search bar related
        searchController.searchResultsUpdater = self as UISearchResultsUpdating       //This will let the class be informed of any text changes in the search bar
        searchController.dimsBackgroundDuringPresentation = false   //This will not let the view controller get dim when a search is performed.
        definesPresentationContext = true   //this will make sure that the search bar will not be active in other screens
        tableView.tableHeaderView = searchController.searchBar  //This will add the search bar to table header view
        
    }

    //This function returns the filtered data
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredObject = tableObject.filter { item in
            return item.website.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    //This function submits a url request to get the json formatted data from the source as indicated in url string.
    func fetchJsonData() {
        
        //fetching fox news latest articles
        //let api_url = URL(string: "http://students.cs.niu.edu/~z1788719/jsondata.json")
        let api_url = URL(string: "http://students.cs.niu.edu/~z1788719/userpass/userpassrequest.php")
        
        //create a URL request with the API address
        let urlRequest = URLRequest(url: api_url!)
        
        //submit a request to the Json data
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data,response,error) in
            //if there is an error, print it and do not continue
            if error != nil {
                print(error!)
                return
            }//end if
            
            //if there is no error, fetch json formatted content
            if let content = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
        
                    //Fetch only the articles
                    if let articlesJson = jsonObject["result"] as? [[String:AnyObject]] {
                        
                        for item in articlesJson {
                            
                            if let username = item["username"] as? String,
                                let password = item["password"] as? String,
                                let website = item["website"] as? String,
                                let sno = item["sno"] as? String
                            {
                                /*
                                print("*****MARK: BEGIN*****")
                                print(sno, username, password, website)
                                print("*****MARK: END*****")
                                */
                                self.tableObject.append(UandPList(sno: sno, username : username, password : password, website : website))
                                
                            }//end if
                            
                        }//end for loop
                        
                    }//end if
                    
                    //if you are using a table view, you would reload the data
                    self.tableView.reloadData()
                    
                    
                }//end do
                    
                catch {
                    
                    print(error)
                    
                }//end catch
                
            }//end if
            
        }//end getdatasession
        
        task.resume()
        
    }//end function

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
