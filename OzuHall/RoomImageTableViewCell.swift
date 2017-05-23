//
//  RoomImageTableViewCell.swift
//  OzuHall
//
//  Created by Firat Kaptan on 13/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class RoomImageTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: CustomizableImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var postHeaderLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
