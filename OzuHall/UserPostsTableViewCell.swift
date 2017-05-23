//
//  UserPostsTableViewCell.swift
//  OzuHall
//
//  Created by Firat Kaptan on 14/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class UserPostsTableViewCell: UITableViewCell {
    
    var comment:UserComment!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var postNameLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
