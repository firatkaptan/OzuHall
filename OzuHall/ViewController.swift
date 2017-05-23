//
//  ViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 25/04/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    
    @IBOutlet weak var conditionLabel: UILabel!
    
    let conditionRef = FIRDatabase.database().reference().child("condition")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        conditionRef.observe(FIRDataEventType.value, with: { (snap:FIRDataSnapshot) in
            self.conditionLabel.text = (snap.value as AnyObject).description
            
        })
    }
    
    @IBAction func touchSunny(_ sender: Any) {
        conditionRef.setValue("Sunny")
    }
    
    @IBAction func touchRainy(_ sender: Any) {
        conditionRef.setValue("Rainy")
    }

}

