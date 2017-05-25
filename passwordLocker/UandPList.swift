//
//  UandPList.swift
//  passwordLocker
//
//  Created by Kartheek chintalapati on 21/05/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

/****************************************************************
 COMMIT HISTORY:
 commit 1: initial commit
 commit 5: added a new parameter into the object called sno
 ****************************************************************/


/*******************************************************
 This file defines an object to import data from plist.
 *******************************************************/
import UIKit

class UandPList: NSObject {

    var sno: String!
    var username : String!
    var password : String!
    var website : String!
    
    init(sno: String, username : String, password : String, website : String)
    {
        self.sno = sno
        self.username = username
        self.password = password
        self.website = website
    }
    
}
