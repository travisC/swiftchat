//
//  ProfileTableViewCell.swift
//  swiftchat
//
//  Created by Travis Cunningham on 11/18/17.
//  Copyright © 2017 Travis Cunningham. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var cellName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
