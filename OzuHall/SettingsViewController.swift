//
//  SettingsViewController.swift
//  OzuHall
//
//  Created by Firat Kaptan on 13/05/2017.
//  Copyright © 2017 Firat Kaptan. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image:UIImage!
    @IBOutlet weak var changePictureButton: CustomizableButton!
    var url:URL!
    var networkingService = NetworkingService()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.kf.setImage(with: url)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        imageView.image=image
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutAction(_ sender: Any) {
        networkingService.logOut()
    }

    @IBAction func closePopUp(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    @IBAction func changePicture(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Change Picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ (action) in pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            
        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.sourceView = self.view;
        alertController.popoverPresentationController?.sourceRect = CGRect(x:self.view.bounds.size.width / 2.0, y:self.view.bounds.size.height / 2.0, width:1.0, height:1.0);
        
        //alertController.popoverPresentationController?.sourceRect = self.view.bounds
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
        self.image=image
        
        let data = UIImageJPEGRepresentation(image, 1.0)!
        networkingService.setUserImage(data: data)
        self.imageView.image = image
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPasswordAction(_ sender: Any) {
        networkingService.resetPassword()
    }
    
    @IBAction func changeUserName(_ sender: Any) {
        networkingService.setUserName(username: "firatkaptan92")
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
