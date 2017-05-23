//
//  CreateRoomViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 14/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit


class CreateRoomViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var createButton: UIBarButtonItem!
    @IBOutlet weak var headerTextField: CustomizableTextField!
    @IBOutlet weak var contentTextView: CustomizableTextView!
    let postalService = PostalService()
    var roomName:String!
    var postDict = [String:Post]()
    var roomDict = [String:Room]()
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate=self
        headerTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if((textView.text=="Enter description...")){
            textView.text=""
            textView.textColor=UIColor.black
            
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text==""){
            textView.textColor=UIColor.lightGray
            textView.text="Enter description..."
            
        }
    }
    @IBAction func create(_ sender: Any) {
        if(roomName==nil){
            if((headerTextField.text! != "")){
                if((contentTextView.text != "Enter description...") && (contentTextView.text != "")){
                    if roomDict[headerTextField.text!] != nil{
                        print("room exists")
                    }else{
                        postalService.createRoom(roomName: headerTextField.text!, description: contentTextView.text!)
                        print("room created")
                        _ = navigationController?.popViewController(animated: true)
                    }
                }else{
                    print("enter description")
                }
            }else{
                print("header cant be empty")
                
            }
            
        }else{
            if((headerTextField.text! != "")){
                if((contentTextView.text != "Enter description...") && (contentTextView.text != "")){
                    if postDict[headerTextField.text!] != nil{
                        print("post exists")
                    }else{
                        postalService.createPost(roomName:roomName,postName: headerTextField.text!, description: contentTextView.text!)
                        print("post created")
                        _ = navigationController?.popViewController(animated: true)
                    }
                    
                }else{
                    print("enter description")
                }
            }else{
                print("header cant be empty")
                
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if (textField==headerTextField){
            textField.resignFirstResponder()
            contentTextView.becomeFirstResponder()
            return false
        }
        
        return true
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
