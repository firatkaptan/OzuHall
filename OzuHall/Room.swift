//
//  Room.swift
//  OzuHall
//
//  Created by Firat Kaptan on 16/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct Room {
    
    var roomName: String!
    var description: String!
    var ref: FIRDatabaseReference?
    var key: String
    var posts = [String:Post]()
    
    init(snap: FIRDataSnapshot){
        
        key = snap.key
        ref = snap.ref
        roomName = (snap.value as! [String:Any])["roomName"] as! String
        description = (snap.value as! [String:Any])["roomDescription"] as! String
        
        for item in snap.childSnapshot(forPath: "posts").children {
            let newPost = Post(snapshot: item as! FIRDataSnapshot)
            posts[newPost.postName] = newPost
            
        }
        
        
        
    }
}
