//
//  CreateCommentViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 17/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class CreateCommentViewController: UIViewController ,UITextViewDelegate{
    @IBOutlet weak var sendButton: UIBarButtonItem!

    @IBOutlet weak var textView: CustomizableTextView!
    let postalService = PostalService()
    var roomName:String!
    var postName:String!
    var postDict = [String:Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if((textView.text=="Enter comment...")){
            textView.text=""
            textView.textColor=UIColor.black
            
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text==""){
            textView.textColor=UIColor.lightGray
            textView.text="Enter comment..."
            
        }
    }
    @IBAction func create(_ sender: Any) {
        
        
            if((textView.text != "Enter comment...") && (textView.text != "")){
                
                if (postDict[postName]?.comments.contains(where: { $0.comment == textView.text }))! {
                    print("post exists")
                }
                else {
                    postalService.createComment(roomName:roomName,postName: postName, comment: textView.text!)
                    print("comment created")
                    _ = navigationController?.popViewController(animated: true)
                }
            }else{
                print("enter description")
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
