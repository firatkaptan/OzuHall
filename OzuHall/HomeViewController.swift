//
//  HomeViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 12/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataServiceDelegate {
    
    let dataService = DataService()
    var roomDict = [String:Room]()
    var userDict = [String:User]()
    var delegate : AppDelegate!{
        return UIApplication.shared.delegate as! AppDelegate
    }
    @IBOutlet weak var roomTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomTableView.rowHeight = UITableViewAutomaticDimension
        roomTableView.estimatedRowHeight = 55
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Room1", for: indexPath) as! HomeTableViewCell
        
        let key = Array(roomDict.keys)[indexPath.row]
        let room = roomDict[key]!
        
        cell.room = room
        cell.roomNameLabel.text = room.roomName
        cell.roomDescriptionLabel.text = room.description
        cell.postCountLabel.text = "\(room.posts.count)"
        
        
        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomDict.count
    }
    func loaded() {
        DispatchQueue.main.async {
            self.roomDict = self.dataService.roomDict
            self.roomTableView.reloadData()
        }
        
    }
    func usersLoaded(){
        self.userDict = self.dataService.userDict
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        if let cvc = vc as? CreateRoomViewController{
            cvc.title = "Create a Room"
            cvc.roomDict = self.roomDict
        }else if let rvc = segue.destination as? RoomViewController{
            if sender is HomeTableViewCell{
                
                let roomCell = sender as! HomeTableViewCell
                let indexPath = self.roomTableView.indexPath(for: roomCell)
                rvc.roomName = roomCell.roomNameLabel.text
                rvc.postDict = roomDict[roomCell.roomNameLabel.text!]!.posts
                rvc.userDict = userDict
                rvc.indexPath = indexPath!.row
                
            }
            
        }else if let pvc = segue.destination as? ProfileViewController{
            pvc.user = userDict[delegate.getCurrentUser().uid]
        }
    }

}
