//
//  CommentTableViewCell.swift
//  OzuHall
//
//  Created by Firat Kaptan on 14/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: CustomizableButton!
    @IBOutlet weak var likeCountLabel: CustomizableLabel!
    @IBOutlet weak var userImageView: CustomizableImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var user : User!
    var comment : Comment!
    var delegate : CommentTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        userImageView.addGestureRecognizer(tap)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func singleTap(){
        delegate?.commentTableViewCell(tapActionDelegatedFrom:self)
    }
    func tapAction(){
        
            self.singleTap()
        
        
    }

}
