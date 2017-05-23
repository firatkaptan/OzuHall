//
//  User.swift
//  OzuHall
//
//  Created by Firat Kaptan on 06/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
    var username: String!
    var email: String!
    var photoUrl: String!
    var uid: String!
    var ref: FIRDatabaseReference?
    var key: String
    var posts : [UserComment] = []
    var followerArray : [String] = []
    var followingArray : [String] = []
    
    init(snapshot: FIRDataSnapshot){
        key = snapshot.key
        ref = snapshot.ref
        username = (snapshot.value as! [String:Any])["username"] as! String
        email = (snapshot.value as! [String:Any])["email"] as! String
        photoUrl = (snapshot.value as! [String:Any])["photoUrl"] as! String
        uid = (snapshot.value as! [String:Any])["uid"] as! String
        
        for item in snapshot.childSnapshot(forPath: "followers").children {
            let follower = ((item as! FIRDataSnapshot).key )
            followerArray.append(follower)
            
        }
        for item in snapshot.childSnapshot(forPath: "following").children {
            let following = ((item as! FIRDataSnapshot).key )
            followingArray.append(following)
            
        }
        for item in snapshot.childSnapshot(forPath: "comments").children {
            
            posts.append(UserComment(snapshot: item as! FIRDataSnapshot))
            
            
        }     
        
    }
    
    
    
    
    
    
    
}
