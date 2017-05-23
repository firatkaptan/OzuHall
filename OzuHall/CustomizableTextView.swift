//
//  CustomizableTextView.swift
//  OzuHall
//
//  Created by Firat Kaptan on 14/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

@IBDesignable class CustomizableTextView: UITextView {
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        
        didSet {
            layer.cornerRadius = cornerRadius
        }
        
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        
        didSet {
            layer.borderWidth = borderWidth
        }
        
    }
    
    @IBInspectable var borderColor: UIColor =  UIColor.gray{
    
        didSet {
            layer.borderColor = borderColor.cgColor
        }
        
    }
}
//UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.00)
