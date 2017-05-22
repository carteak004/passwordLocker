//
//  UandPList.swift
//  passwordLocker
//
//  Created by Kartheek chintalapati on 21/05/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/*******************************************************
 This file defines an object to import data from plist.
 *******************************************************/
import UIKit

class UandPList: NSObject {

    var username : String!
    var password : String!
    var website : String!
    
    init(username : String, password : String, website : String)
    {
        self.username = username
        self.password = password
        self.website = website
    }
    
}
