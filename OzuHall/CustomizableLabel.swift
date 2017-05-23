//
//  CustomizableLabel.swift
//  OzuHall
//
//  Created by Firat Kaptan on 17/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class CustomizableLabel: UILabel{
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds=true
        }
        
    }
}
