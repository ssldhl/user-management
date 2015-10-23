//
//  UpdateUserViewController.swift
//  User Management
//
//  Created by Sushil Dahal on 10/23/15.
//  Copyright © 2015 Sushil Dahal. All rights reserved.
//

import UIKit
import Parse

class UpdateUserViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    var menu:MenuViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let firstName = PFUser.currentUser()?.objectForKey("first_name") as! String
        let lastName = PFUser.currentUser()?.objectForKey("last_name") as! String
        firstNameField.text = firstName
        lastNameField.text = lastName
        
        if(PFUser.currentUser()?.objectForKey("profile_picture") != nil){
            let profilePictureData: PFFile = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
            profilePictureData.getDataInBackgroundWithBlock({ (profilePicture:NSData?, error:NSError?) -> Void in
                if(error == nil){
                    self.profilePictureView.image = UIImage(data: profilePicture!)
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func selectProfilePicture(sender: UIButton) {
        let profilePictureSelector = UIImagePickerController()
        profilePictureSelector.delegate = self
        profilePictureSelector.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(profilePictureSelector, animated: true, completion: nil)
    }
    
    @IBAction func update(sender: UIButton) {
        let user:PFUser = PFUser.currentUser()!
        let firstName = firstNameField.text
        let lastName = lastNameField.text
        let password = passwordField.text
        let confirmPassword = confirmPasswordField.text
        var valid:Bool = true
        self.view.endEditing(true)
        
        if(!password!.isEmpty){
            if(confirmPassword == nil || password != confirmPassword){
                displayAlert("Password do not match", dismiss: false)
                valid = false
            }else{
                user.password = password
            }
        }
        
        if(valid){
            if(firstName!.isEmpty || lastName!.isEmpty){
                displayAlert("First Name or Last Name cannot be empty", dismiss: false)
                valid = false
            }else{
                user.setObject(firstName!, forKey: "first_name")
                user.setObject(lastName!, forKey: "last_name")
                if(profilePictureView.image != nil){
                    let profilePicture = UIImageJPEGRepresentation(profilePictureView.image!, 1)
                    if(profilePicture != nil){
                        let profilePictureFile = PFFile(data: profilePicture!)
                        user.setObject(profilePictureFile!, forKey: "profile_picture")
                    }
                }
            }
            
            if(valid){
                let spinner = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
                spinner.labelText = "Please Wait"
                
                user.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                    if(success){
                        self.dismissViewControllerAnimated(true, completion: { () -> Void in
                            self.menu.loadUserDefaults()
                        })
                    }else{
                        self.displayAlert(error!.localizedDescription, dismiss: false)
                    }
                })
            }
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        profilePictureView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func displayAlert(message: String, dismiss: Bool){
        let validationAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            if(dismiss){
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        validationAlert.addAction(alertAction)
        
        self.presentViewController(validationAlert, animated: true, completion: nil)
    }

}
