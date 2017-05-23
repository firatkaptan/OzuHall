//
//  UserPostsViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 14/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class UserPostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var userPostsTableView: UITableView!
    var dataService = DataService()
    var delegate : AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    var posts : [UserComment]=[]
    var user : User!
    override func viewDidLoad() {
        super.viewDidLoad()
        userPostsTableView.rowHeight = UITableViewAutomaticDimension
        userPostsTableView.estimatedRowHeight = 90
        
        dataService.observeUsers {
            self.usersLoaded()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func usersLoaded(){
        self.posts = (self.dataService.userDict[user.uid]?.posts)!
        userPostsTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Post1", for: indexPath) as! UserPostsTableViewCell
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
