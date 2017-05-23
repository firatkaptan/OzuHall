//
//  NetworkingService.swift
//  OzuHall
//
//  Created by Firat Kaptan on 06/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage


class NetworkingService{
    var databaseRef:FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    var storageRef:FIRStorageReference!{
        return FIRStorage.storage().reference()
    }
    var delegate : AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    private func saveInfo(user: FIRUser, username:String){
        
        let userInfo = ["email":user.email,"username":username,"uid":user.uid,"photoUrl": "\(user.photoURL!)"]
        let userRef = databaseRef.child("Users").child(user.uid)
        userRef.setValue(userInfo)
        
        
    }
    private func saveInfo(user: FIRUser, username:String,password:String){
        
        let userInfo = ["email":user.email,"username":username,"uid":user.uid,"photoUrl": "\(user.photoURL!)"]
        let userRef = databaseRef.child("Users").child(user.uid)
        userRef.setValue(userInfo)
        logIn(email: user.email!, password: password)
        
    }
    func logIn(email:String,password:String){
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user,error) in
            if error==nil{
                if let user = user {
                    print("\(user.displayName!) has signed in successfully!")
                    
                    self.delegate?.logUser()
                    
                }
                
            }else{
                print(error!.localizedDescription)
            }
            
        })
    }
    func resetPassword(email: String){
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                
                print("password reseted")
                
                
                
            }else {
                
                print(error!.localizedDescription)
            }
        })
        
    }
    func getCurrentUserRef()->FIRDatabaseReference!{
        return FIRDatabase.database().reference().child("Users").child((FIRAuth.auth()?.currentUser?.uid)!)
        
    }
    func setCurrentUser(){
        var currentUser:User?
        getCurrentUserRef().observeSingleEvent(of: .value, with: { snapshot in
            currentUser = User(snapshot: snapshot)
            self.delegate.currentUser =  currentUser!
        })
        
    }
    func resetPassword(){
        FIRAuth.auth()?.sendPasswordReset(withEmail: (FIRAuth.auth()?.currentUser?.email)!, completion: { (error) in
            if error == nil {
                
                print("password reseted")
                
                
                
            }else {
                
                print(error!.localizedDescription)
            }
        })
    }
    func logOut() {
        
        if FIRAuth.auth()!.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                
                self.delegate.logUser()
                
            } catch let error as NSError {
                
                print(error.localizedDescription)
                
            }
        }
        
        
    }
    
    private func setUserInfo(user: FIRUser!, username:String, password:String,data:Data!){
        
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        let imageRef = storageRef.child(imagePath)
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        imageRef.put(data, metadata: metaData) { (metaData, error) in
            if(error==nil){
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    if(error==nil){
                        self.saveInfo(user: user, username: username,password:password)
                        
                    }else{
                        print(error!.localizedDescription)
                    }
                })
            }else{
                print(error!.localizedDescription)
            }
        }
        
        
    }
    func setUserName(username:String){
        
        let user = (FIRAuth.auth()?.currentUser)!
        
        
        
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = username
        changeRequest.commitChanges(completion: { (error) in
            if(error==nil){
                let userNameRef = self.databaseRef.child("Users").child(user.uid).child("username")
                userNameRef.setValue(username)
                
                print("Username updated")
                print((user.displayName)!)
                        
            }else{
                print(error!.localizedDescription)
            }
        })
            

        
    }

    func setUserImage(data:Data!){
        
        let user = (FIRAuth.auth()?.currentUser)!
        
        let username = (user.displayName)!
        
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        let imageRef = storageRef.child(imagePath)
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        imageRef.put(data, metadata: metaData) { (metaData, error) in
            if(error==nil){
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    if(error==nil){
                        let imageRef = self.databaseRef.child("Users").child(user.uid).child("photoUrl")
                        imageRef.setValue("\(metaData!.downloadURL()!)")
                        
                    }else{
                        print(error!.localizedDescription)
                    }
                })
            }else{
                print(error!.localizedDescription)
            }
        }
        
        
    }
    func registerUser(username: String, email: String, password: String, data: Data!){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if(error==nil){
                self.setUserInfo(user: user, username: username, password: password, data: data)
                print("Registered successfully!")
                //self.delegate.logUser()
                
            }else{
                print(error!.localizedDescription)
            }
        })
    }
    
}

