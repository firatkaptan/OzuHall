//
//  PostViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 13/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit
import Kingfisher
protocol CommentTableViewCellDelegate {
    func commentTableViewCell(tapActionDelegatedFrom cell: CommentTableViewCell)
    
}

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CommentTableViewCellDelegate{
    func commentTableViewCell(tapActionDelegatedFrom cell: CommentTableViewCell) {
        //let indexPath = postTableView.indexPath(for: cell)
        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        profileViewController.username=cell.userNameLabel.text
        profileViewController.image=cell.imageView?.image
        profileViewController.followUnFollowImage = #imageLiteral(resourceName: "Add User Group Man Man-30")
        profileViewController.user = userDict[cell.comment.userUid]
        profileViewController.userUid = cell.comment.userUid
        profileViewController.userDict = userDict
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }

    
    var dataService = DataService()
    var commentArray = [Comment]()
    var roomName: String!
    var postName: String!
    var userDict = [String:User]()
    var postDict = [String:Post]()
    var delegate : AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    @IBOutlet weak var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.rowHeight = UITableViewAutomaticDimension
        postTableView.estimatedRowHeight = 87
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let cell = tableView.cellForRow(at: indexPath) as? CommentTableViewCell {
            if let cellUserId = cell.comment?.userUid{
                if(cellUserId == delegate.getCurrentUser().uid){
                    return true
                }
            }
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            
            if let cell = tableView.cellForRow(at: indexPath) as? CommentTableViewCell{
                dataService.deleteComment(commentRef: cell.comment.ref!, userUid: cell.comment.userUid, comment: cell.comment.comment)
                commentArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
                
            
        }
    }
    
    @IBAction func likeComment(_ sender: Any) {
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? CommentTableViewCell{
                    if(button.backgroundColor==UIColor.red){
                        dataService.unlikeComment(commentRef: (commentArray[(postTableView.indexPath(for: cell)?.row)!].ref)!)
                        button.backgroundColor=UIColor.init(red: 0/255, green: 64/255, blue: 128/255, alpha: 1)
                    }else if(button.backgroundColor == UIColor.init(red: 0/255, green: 64/255, blue: 128/255, alpha: 1)){
                        dataService.likeComment(commentRef: (commentArray[(postTableView.indexPath(for: cell)?.row)!].ref)!)
                        button.backgroundColor=UIColor.red
                    }
                }
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Comment1", for: indexPath) as! CommentTableViewCell
        let comment = commentArray[indexPath.row]
        
        cell.comment=comment
        cell.commentLabel.text = comment.comment
        cell.likeCountLabel.text = comment.likeCount
        
        if(comment.likedUsers.contains(delegate.getCurrentUser().uid)){
            cell.likeButton.backgroundColor=UIColor.red
        }else{
            cell.likeButton.backgroundColor=UIColor.init(red: 0/255, green: 64/255, blue: 128/255, alpha: 1)
        }
        
        if(userDict[comment.userUid] != nil){
            let user = userDict[comment.userUid]!
            let url = URL(string: (user.photoUrl!))
            // using external library kf
            
            cell.userImageView.kf.setImage(with: url)
            cell.userNameLabel.text = user.username
            
        }
        cell.delegate=self
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    func loaded(){
        DispatchQueue.main.async {
            self.commentArray = (self.dataService.roomDict[self.roomName]?.posts[self.postName]?.comments)!
            self.postTableView.reloadData()
        }
    }
    func usersLoaded(){
        DispatchQueue.main.async {
            self.userDict = self.dataService.userDict
            self.postTableView.reloadData()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ccvc = segue.destination as? CreateCommentViewController{
            ccvc.title = "Add a Comment"
            ccvc.roomName = roomName
            ccvc.postName = postName
            ccvc.postDict = self.postDict
            }
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
