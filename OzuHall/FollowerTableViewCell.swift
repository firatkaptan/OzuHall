//
//  FollowerTableViewCell.swift
//  OzuHall
//
//  Created by Firat Kaptan on 13/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {
    var user: User!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var userMailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImage: CustomizableImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
