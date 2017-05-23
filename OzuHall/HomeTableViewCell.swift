//
//  HomeTableViewCell.swift
//  OzuHall
//
//  Created by Firat Kaptan on 13/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    var room: Room!
    @IBOutlet weak var postCountLabel: CustomizableLabel!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var roomDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
