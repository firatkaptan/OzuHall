//
//  ContactsViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 13/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contacts1", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cvc = segue.destination as? ChatViewController{
            if let cell = sender as? UserTableViewCell{
                
                cvc.targetUserName=cell.userNameLabel.text
            }
        }
    }
    
}
