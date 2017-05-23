//
//  CustomizableButton.swift
//  OzuHall
//
//  Created by Firat Kaptan on 13/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit


@IBDesignable class CustomizableButton: UIButton {
        
    @IBInspectable var cornerRadius: CGFloat = 0 {
            
        didSet {
            layer.cornerRadius = cornerRadius
        }

    }
}
