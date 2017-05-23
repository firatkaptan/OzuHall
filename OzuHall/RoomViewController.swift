//
//  RoomViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 12/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit
import Kingfisher

protocol RoomTableViewCellDelegate {
    func roomTableViewCell(tapActionDelegatedFrom cell: RoomTableViewCell)
    
}


class RoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,DataServiceDelegate, RoomTableViewCellDelegate{
    func roomTableViewCell(tapActionDelegatedFrom cell: RoomTableViewCell) {
        //let indexPath = tableView.indexPath(for: cell)
        
        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        profileViewController.username=cell.userNameLabel.text
        profileViewController.image=cell.userImage.image
        profileViewController.followUnFollowImage = #imageLiteral(resourceName: "Add User Group Man Man-30")
        profileViewController.user = userDict[cell.post.userUid]
        profileViewController.userUid = cell.post.userUid
        profileViewController.userDict = userDict
        self.navigationController?.pushViewController(profileViewController, animated: true)
        //self.show(profileViewController, sender: true)
    }

    @IBOutlet weak var tableView: UITableView!
    var roomName:String!
    var postDict = [String:Post]()
    var userDict = [String:User]()
    var indexPath:Int!
    var dataService = DataService()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 87
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        dataService.observeRooms {
            self.loaded()
        }
        dataService.observeUsers {
            self.usersLoaded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post1", for: indexPath) as! RoomTableViewCell
        
        
        let key = Array(postDict.keys)[indexPath.row]
        let post = postDict[key]!
        
        cell.postHeaderLabel.text = post.postName
        cell.postContentLabel.text = post.description
        cell.post = post
        if(userDict[post.userUid] != nil){
            let user = userDict[post.userUid]!
            let url = URL(string: (user.photoUrl!))
            cell.userImage.kf.setImage(with: url)
            cell.userNameLabel.text = user.username
        }
        cell.commentCountLabel.text = "\(post.comments.count)"
        //print("THIS  \(userDict[post.userUid]) ANDDDDDDD \(userDict[post.userUid]?.photoUrl)")
        //let url =
        //let photoURL = userDict[post.userUid]?.photoUrl!
        
        cell.delegate=self
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDict.count
    }
    func loaded() {
        DispatchQueue.main.async {
            self.postDict = (self.dataService.roomDict[self.roomName]?.posts)!
            self.tableView.reloadData()
        }
        
    }
    func usersLoaded(){
        DispatchQueue.main.async {
            
            self.userDict = self.dataService.userDict
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        if let crvc = segue.destination as? CreateRoomViewController{
            crvc.title = "Create a Post"
            crvc.roomName = roomName
            crvc.postDict=self.postDict
            
        }else if let crvc = segue.destination as? PostViewController{
            if sender is RoomTableViewCell{
                let roomCell = sender as! RoomTableViewCell
                let postName = roomCell.postHeaderLabel.text!
                //crvc.title = postName
                crvc.commentArray = postDict[postName]!.comments
                crvc.userDict = userDict
                crvc.postName = postName
                crvc.roomName = roomName
                crvc.postDict = self.postDict
            }else if sender is RoomImageTableViewCell{
                let roomImageCell = sender as! RoomImageTableViewCell
                vc.title = roomImageCell.postHeaderLabel.text
                
            }
            
        }
//        else if let pvc = segue.destination as? ProfileViewController{
//            if let cell = sender as? RoomTableViewCell{
//                
//                pvc.username=cell.userNameLabel.text
//                pvc.image=cell.userImage.image
//                pvc.followUnFollowImage = #imageLiteral(resourceName: "Add User Group Man Man-30")
//            }
//        }
        
        
        
        
        
        
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
