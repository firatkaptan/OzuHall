//
//  DataService.swift
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

@objc protocol DataServiceDelegate {
    func loaded()
}


class DataService{
    var roomDict = [String:Room]()
    var userDict = [String:User]()
    var roomArray = [Room]()
    
    
    var delegate : AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var databaseRef:FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    var storageRef:FIRStorageReference!{
        return FIRStorage.storage().reference()
    }
    func observeRooms(onCompletion: @escaping () -> Void){
        databaseRef.child("Rooms").removeAllObservers()
        databaseRef.child("Rooms").observe(.value, with: { (snap:FIRDataSnapshot) in
            self.roomDict.removeAll()
            for item in snap.children {
                let newRoom = Room(snap: item as! FIRDataSnapshot)
                self.roomDict[newRoom.roomName] = newRoom
            }
            self.delegate.setRoomDict(dict: self.roomDict)
            onCompletion()
        })
    }
    
    func observeUsers(onCompletion: @escaping () -> Void){
        databaseRef.child("Users").removeAllObservers()
        databaseRef.child("Users").observe(.value, with: { (snap:FIRDataSnapshot) in
            self.userDict.removeAll()
            for item in snap.children {
                let newUser = User(snapshot: item as! FIRDataSnapshot)
                self.userDict[newUser.uid] = newUser
                
            }
            self.delegate.setUserDict(dict: self.userDict)
            onCompletion()
        })
    }
    func likeComment(commentRef:FIRDatabaseReference){
        commentRef.child("likeCount").observeSingleEvent(of: .value, with: { snapshot in
            let valString = (snapshot.value as! String)
            var value = (valString as NSString).integerValue
            value = value + 1
            commentRef.child("likeCount").setValue("\(value)")
            commentRef.child("users").child(self.delegate.currentUser.uid).setValue(self.delegate.currentUser.uid)
        })
    }
    func unlikeComment(commentRef:FIRDatabaseReference){
        commentRef.child("likeCount").observeSingleEvent(of: .value, with: { snapshot in
            let valString = (snapshot.value as! String)
            var value = (valString as NSString).integerValue
            value = value - 1
            commentRef.child("likeCount").setValue("\(value)")
            commentRef.child("users").child(self.delegate.currentUser.uid).removeValue(completionBlock: { (error, ref) in
                if error != nil {
                    print("error \(error!.localizedDescription)")
                }
            })
        })
    }

    func followUser(userRef:FIRDatabaseReference,followerUid: String,followerUserName:String,userUid:String,username:String){
            userRef.child("followers").child(followerUid).setValue(followerUserName)
            let followerRef = userDict[followerUid]?.ref
            followerRef!.child("following").child(userUid).setValue(username)
        
        }
    func unFollowUser(userRef:FIRDatabaseReference,followerUid: String,followerUserName:String,userUid:String,username:String){
        userRef.child("followers").child(followerUid).removeValue(completionBlock: { (error, ref) in
            if error != nil {
                print("error \(error!.localizedDescription)")
            }
        })
        let followerRef = userDict[followerUid]?.ref
        followerRef!.child("following").child(userUid).removeValue(completionBlock: { (error, ref) in
            if error != nil {
                print("error \(error!.localizedDescription)")
            }
        })
        
    }
    func deleteComment(commentRef:FIRDatabaseReference,userUid:String,comment:String){
        print(commentRef)
        print(comment)
        commentRef.removeValue(completionBlock: { (error, ref) in
            if error != nil {
                print("error \(error!.localizedDescription)")
            }
        })
        databaseRef.child("Users").child(userUid).child("comments").child(comment).removeValue(completionBlock: { (error, ref) in
            if error != nil {
                print("error \(error!.localizedDescription)")
            }
        })

        
    }
    
    /* var newRooms = [Room]()
     
     for item in snap.children {
     
     let newRoom = Room(snap: item as! FIRDataSnapshot)
     newRooms.insert(newRoom, at: 0)
     
     }
     self.roomArray = newRooms*/
    
}
