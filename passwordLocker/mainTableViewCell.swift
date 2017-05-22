//
//  mainTableViewCell.swift
//  passwordLocker
//
//  Created by Kartheek chintalapati on 21/05/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class mainTableViewCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
