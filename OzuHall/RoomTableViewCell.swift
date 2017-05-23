//
//  RoomTableViewCell.swift
//  OzuHall
//
//  Created by Firat Kaptan on 13/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: CustomizableImageView!

    @IBOutlet weak var commentCountLabel: CustomizableLabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postContentLabel: UILabel!
    @IBOutlet weak var postHeaderLabel: UILabel!
    var post : Post!
    var user: User!
    var delegate : RoomTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        userImage.addGestureRecognizer(tap)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func tapAction(){
        
        self.singleTap()
        
        
    }
    func singleTap(){
        delegate?.roomTableViewCell(tapActionDelegatedFrom:self)
    }
    

}
