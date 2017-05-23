//
//  PostalService.swift
//  OzuHall
//
//  Created by Firat Kaptan on 16/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class PostalService{
    var databaseRef:FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    var storageRef:FIRStorageReference!{
        return FIRStorage.storage().reference()
    }
    var delegate : AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    func createRoom(roomName: String, description :String){
        
        let roomInfo = ["roomName":roomName,"roomDescription":description]
        let roomRef = databaseRef.child("Rooms").child(roomName)
        roomRef.setValue(roomInfo)
        
    }
    func createPost(roomName: String,postName:String, description :String){
        let userUid = (delegate.getCurrentUser().uid!)
        let postInfo = ["postName":postName,"postDescription":description,"roomName":roomName,"userUid":userUid,"comments":[description:["postName":postName,"comment":description,"roomName":roomName,"userUid":userUid,"likeCount":String(0)]]] as [String : Any]
        let postRef = databaseRef.child("Rooms").child(roomName).child("posts").child(postName)
        let userRef = databaseRef.child("Users").child(userUid).child("comments").child(description)
        let commentInfo = ["comment":description,"postName":postName,"roomName":roomName]
        userRef.setValue(commentInfo)
        postRef.setValue(postInfo)
    }
    func createComment(roomName: String,postName:String, comment :String){
        let userUid = (delegate.getCurrentUser().uid!)
        let commentInfo = ["postName":postName,"comment":comment,"roomName":roomName,"userUid":userUid,"likeCount":String(0)]
        let commentRef = databaseRef.child("Rooms").child(roomName).child("posts").child(postName).child("comments").child(comment)
        commentRef.setValue(commentInfo)
        let userRef = databaseRef.child("Users").child(userUid).child("comments").child(comment)
        let commentInfo2 = ["comment":comment,"postName":postName,"roomName":roomName]
        userRef.setValue(commentInfo2)
    }

   
    /*func addComment(roomName: String,postName:String, comment :String,likeCount: Int){
        let userUid = (UserDefaults.standard.object(forKey: "uid")! as! String)
        let commentInfo = ["postName":postName,"comment":comment,"roomName":roomName,"userUid":userUid,"likeCount":String(likeCount)]
        let postRef = databaseRef.child("Rooms").child(roomName).child("posts").child(postName).child("comments").child(comment)
        postRef.setValue(commentInfo)
    }*/

}
