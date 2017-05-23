//
//  ProfileViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 12/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController,UIPopoverPresentationControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var userPostsTableView: UITableView!
    @IBOutlet var postsGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet var followingGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var followerGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var followerView: UIView!
    @IBOutlet weak var followingView: UIView!
    @IBOutlet weak var barButton: UIBarButtonItem!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    var userUid:String!
    var user : User!
    var posts : [UserComment] = []
    var username: String!
    var image: UIImage!
    var followUnFollowImage:UIImage!
    var userDict = [String: User]()
    var networkingService = NetworkingService()
    var dataService = DataService()
    var delegate : AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userPostsTableView.rowHeight = UITableViewAutomaticDimension
        userPostsTableView.estimatedRowHeight = 60
        userDict=delegate.getUserDict()
        
        if(self.userUid == nil){
            self.userUid=delegate.currentUser.uid
        }
        
        self.user = self.userDict[self.userUid!]
        self.posts = self.user.posts
        loadProfile()
        
    }
    func usersLoaded(){
        self.userDict = self.delegate.getUserDict()
        self.userPostsTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        loadProfile()
        dataService.observeRooms {
            self.usersLoaded()
            self.loadProfile()
        }
        dataService.observeUsers {
            self.usersLoaded()
            self.loadProfile()
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadProfile(){
        
        
        if((user.uid)! == delegate.currentUser.uid){
            barButton.image=#imageLiteral(resourceName: "Services-30")
            
        }else if ((userDict[delegate.getCurrentUser().uid]?.followingArray)) != nil{
            if(userDict[delegate.getCurrentUser().uid]?.followingArray.contains(user.uid))!{
                
                barButton.image=#imageLiteral(resourceName: "Cancel-30")
            }else{
                barButton.image=#imageLiteral(resourceName: "Add User Group Man Man-30")
                
            }
            
        
            
        }else{
            barButton.image=#imageLiteral(resourceName: "Add User Group Man Man-30")
            
        }
        
        self.user = self.userDict[self.userUid]
        
        let url = URL(string: user.photoUrl)
        profileImageView.kf.setImage(with: url)
        self.userNameLabel.text = user.username
        self.followerCountLabel.text = "\(self.user.followerArray.count)"
        self.followingCountLabel.text = "\(self.user.followingArray.count)"
        self.postCountLabel.text = "\(self.user.posts.count)"
        self.posts = user.posts
    }
    func unFollow(){
        dataService.unFollowUser(userRef: (userDict[userUid!]?.ref)!, followerUid: delegate.currentUser.uid, followerUserName: delegate.currentUser.username, userUid: user.uid,username: user.username)
    }
    func follow(){
        
        dataService.followUser(userRef: (userDict[userUid!]?.ref)!, followerUid: delegate.currentUser.uid, followerUserName: delegate.currentUser.username, userUid: user.uid,username: user.username)
    }
    @IBAction func barButtonAction(_ sender: Any) {
        if let button = sender as? UIBarButtonItem{
            if(button.image==#imageLiteral(resourceName: "Services-30")){
                let popoverVC = self.storyboard?.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
                popoverVC.image=profileImageView.image
                present(popoverVC, animated: true)
                
            }else if(button.image==#imageLiteral(resourceName: "Add User Group Man Man-30")){
                follow()
            }else if(button.image==#imageLiteral(resourceName: "Cancel-30")){
                unFollow()
                
            }
        }
    }
    
    @IBAction func unwindWithSegue(segue:UIStoryboardSegue) {
        if let svc = segue.source as? SettingsViewController{
            profileImageView.image = svc.image
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let svc = segue.destination as? SettingsViewController{
            svc.image = profileImageView.image
            svc.url = URL(string: user.photoUrl)
        }else if let fvc = segue.destination as? FollowerViewController{
            if sender as! UITapGestureRecognizer == followerGestureRecognizer{
                fvc.title = "Followers"
            }else if sender as! UITapGestureRecognizer == followingGestureRecognizer{
                fvc.title = "Following"
            }
            
            fvc.userDict = userDict
            fvc.user = user
            
            
        }
        else if let upvc = segue.destination as? UserPostsViewController{
            if sender as! UITapGestureRecognizer == postsGestureRecognizer{
                upvc.title = "Posts"
                upvc.posts = user.posts
                upvc.user = user
            }            
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post2", for: indexPath) as! UserPostsTableViewCell
        let post = posts[indexPath.row]
        cell.comment = posts[indexPath.row]
        cell.roomNameLabel.text = post.roomName
        cell.postNameLabel.text = post.postName
        cell.commentLabel.text = post.comment
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
}
