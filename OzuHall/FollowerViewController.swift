//
//  FollowerViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 13/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class FollowerViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var followerTableView: UITableView!
    
    var delegate : AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var dataService = DataService()
    var user:User!
    var userDict = [String:User]()
    @IBOutlet weak var roomTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func usersLoaded(){
        self.userDict = self.delegate.getUserDict()
        self.user = self.userDict[self.user.uid]
        followerTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        dataService.observeUsers {
            
            self.usersLoaded()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Follower1", for: indexPath) as! FollowerTableViewCell
        if(title=="Followers"){
            let followerUid = user.followerArray[indexPath.row]
            if(userDict[followerUid] != nil){
                let follower = userDict[followerUid]
                cell.user = follower
                cell.userNameLabel.text = follower!.username!
                cell.userMailLabel.text = follower!.email!
                let url = URL(string: (follower!.photoUrl!))
                cell.userImage.kf.setImage(with: url)
                
                if(delegate.getCurrentUser().uid==followerUid){
                    
                    cell.followButton.setImage(nil, for: .normal)
                }else if(userDict[delegate.getCurrentUser().uid]?.followingArray.contains(follower!.uid))!{
                    
                    
                    cell.followButton.setImage(#imageLiteral(resourceName: "Cancel-30"), for: .normal)
                }else{
                    
                    cell.followButton.setImage(#imageLiteral(resourceName: "Add User Group Man Man-30"), for: .normal)
                }
                
                return cell
            }
            
        }else if (title == "Following" ){
            let followingUid = user.followingArray[indexPath.row]
            if(userDict[followingUid] != nil){
                let following = userDict[followingUid]
                cell.user = following
                cell.userNameLabel.text = following?.username!
                cell.userMailLabel.text = following?.email!
                
                let url = URL(string: (following?.photoUrl!)!)
                cell.userImage.kf.setImage(with: url)
                if(delegate.getCurrentUser().uid==followingUid){
                    cell.followButton.setImage(nil, for: .normal)
                }else if(userDict[delegate.getCurrentUser().uid]?.followingArray.contains(following!.uid))!{
                    cell.followButton.setImage(#imageLiteral(resourceName: "Cancel-30"), for: .normal)
                }else{
                    cell.followButton.setImage(#imageLiteral(resourceName: "Add User Group Man Man-30"), for: .normal)
                }
                return cell
            }
            
        }else{
            return cell
        }
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(title=="Followers" ){
            return user.followerArray.count
        }else if (title == "Following" ){
            return user.followingArray.count
        }else{
            return 0
        }
        
    }
    @IBAction func followUnFollow(_ sender: Any?) {
        let followButton = sender as! UIButton
        if(followButton.image(for: .normal)==#imageLiteral(resourceName: "Add User Group Man Man-30")){
            if let button = sender as? UIButton {
                if let superview = button.superview {
                    if let cell = superview.superview as? FollowerTableViewCell {
                        follow(user: cell.user)
                        usersLoaded()
                    }
                }
            }
        }else if (followButton.image(for: .normal)==#imageLiteral(resourceName: "Cancel-30")){
            if let button = sender as? UIButton {
                if let superview = button.superview {
                    if let cell = superview.superview as? FollowerTableViewCell {
                        unFollow(user: cell.user)
                        usersLoaded()
                    }
                }
            }
        }
    }
    func follow(user:User){
        
        dataService.followUser(userRef: (userDict[user.uid!]?.ref)!, followerUid: delegate.currentUser.uid, followerUserName: delegate.currentUser.username, userUid: user.uid,username: user.username)
    }
    func unFollow(user:User){
        
        dataService.unFollowUser(userRef: (userDict[user.uid!]?.ref)!, followerUid: delegate.currentUser.uid, followerUserName: delegate.currentUser.username, userUid: user.uid,username: user.username)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pvc = segue.destination as? ProfileViewController{
            if let cell = sender as? FollowerTableViewCell{
                pvc.userUid = cell.user.uid
                pvc.username=cell.userNameLabel.text
                pvc.image=cell.userImage.image
                pvc.followUnFollowImage = cell.followButton.currentImage
            }
        }
    }
}
