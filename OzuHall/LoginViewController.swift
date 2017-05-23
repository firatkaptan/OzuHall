//
//  LoginViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 06/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    let networkingService = NetworkingService()
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
        if (textField==emailField){
            passwordField.becomeFirstResponder()
        }else if(textField==passwordField) {
            textField.resignFirstResponder()
        }
        
        return true
    }
    @IBAction func loginAction(_ sender: Any) {
        
        networkingService.logIn(email: emailField.text!, password: passwordField.text!)
        
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
