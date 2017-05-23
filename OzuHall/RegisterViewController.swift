//
//  RegisterViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 06/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editingDidBegin(_ sender: Any) {
        
    }

    @IBAction func editingDidEnd(_ sender: Any) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if (textField==emailField){
            usernameField.becomeFirstResponder()
        }else if(textField==usernameField) {
            passwordField.becomeFirstResponder()
        }else if(textField==passwordField) {
            confirmPasswordField.becomeFirstResponder()
        }else if(textField==confirmPasswordField) {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    @IBAction func registerAction(_ sender: Any) {
        let data = UIImageJPEGRepresentation(#imageLiteral(resourceName: "default"), 0.8)
        if(emailField.text!.hasSuffix("@ozu.edu.tr") || emailField.text!.hasSuffix("@ozyegin.edu.tr")){
            if(passwordField.text! == confirmPasswordField.text!){
                networkingService.registerUser(username: usernameField.text!, email: emailField.text!, password: passwordField.text!, data: data!)
            }else{
                print("Password fields do not match.")
            }
        }else {
            print("Please enter Ozu E-mail address.")
        }
        
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
