//
//  Post.swift
//  OzuHall
//
//  Created by Firat Kaptan on 16/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Post {
    var roomName: String!
    var postName: String!
    var description: String!
    var ref: FIRDatabaseReference?
    var key: String
    var comments = [Comment]()
    var userUid: String!
    
    init(snapshot: FIRDataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        postName = (snapshot.value as! [String:Any])["postName"] as! String
        description = (snapshot.value as! [String:Any])["postDescription"] as! String
        roomName = (snapshot.value as! [String:Any])["roomName"] as! String
        userUid = (snapshot.value as! [String:Any])["userUid"] as! String
        
        for item in snapshot.childSnapshot(forPath: "comments").children {
            let newComment = Comment(snapshot: item as! FIRDataSnapshot)
            comments.append(newComment)
        }
        
    }
    
    
    
    
    
    
    
}
