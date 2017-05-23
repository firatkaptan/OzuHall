//
//  Comment.swift
//  OzuHall
//
//  Created by Firat Kaptan on 17/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Comment {
    var roomName: String!
    var postName: String!
    var comment: String!
    var ref: FIRDatabaseReference?
    var key: String
    var userUid: String!
    var likeCount: String!
    var likedUsers : [String] = []
    init(snapshot: FIRDataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        postName = (snapshot.value as! [String:Any])["postName"] as! String
        comment = (snapshot.value as! [String:Any])["comment"] as! String
        roomName = (snapshot.value as! [String:Any])["roomName"] as! String
        userUid = (snapshot.value as! [String:Any])["userUid"] as! String
        if(snapshot.hasChild("likeCount")){
            likeCount = (snapshot.value as! [String:Any])["likeCount"] as! String
        }
        
        
        for item in snapshot.childSnapshot(forPath: "users").children {
            
            likedUsers.append((item as! FIRDataSnapshot).key)
        }
        
        
    }
}
