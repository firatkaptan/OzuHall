//
//  userComment.swift
//  OzuHall
//
//  Created by Firat Kaptan on 18/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct UserComment {
    var roomName: String!
    var postName: String!
    var comment: String!
    var ref: FIRDatabaseReference?
    var key: String
    
    init(snapshot: FIRDataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        postName = (snapshot.value as! [String:Any])["postName"] as! String
        comment = (snapshot.value as! [String:Any])["comment"] as! String
        roomName = (snapshot.value as! [String:Any])["roomName"] as! String
        
    }
}
