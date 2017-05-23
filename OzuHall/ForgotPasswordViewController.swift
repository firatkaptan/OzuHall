//
//  ForgotPasswordViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 06/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController,UITextFieldDelegate {
    var networkingService = NetworkingService()
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        let email = emailField.text!
        networkingService.resetPassword(email: email)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
