//
//  SignUpViewController.swift
//  User Management
//
//  Created by Sushil Dahal on 10/21/15.
//  Copyright © 2015 Sushil Dahal. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        self.edgesForExtendedLayout = UIRectEdge()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectProfilePicture(sender: UIButton) {
        let pictureSelector = UIImagePickerController()
        pictureSelector.delegate = self
        pictureSelector.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pictureSelector, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        profilePictureView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func signUp(sender: UIButton) {
        let user:PFUser = PFUser()
        let emailAddress = emailAddressField.text
        let password = passwordField.text
        let confirmPassword = confirmPasswordField.text
        let firstName = firstNameField.text
        let lastName = lastNameField.text
        var valid:Bool = true
        
        self.view.endEditing(true)
        
        
        if(emailAddress?.isEmpty ?? true || password?.isEmpty ?? true || confirmPassword?.isEmpty ?? true || firstName?.isEmpty ?? true || lastName?.isEmpty ?? true){
            validationAlert("All Fields are required")
            valid = false
        }else if(password != confirmPassword){
            validationAlert("Passwords do not match")
            valid = false
        }else{
            user.username = emailAddress
            user.password = password
            user.email = emailAddress
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
            
            user.signUpInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                
                var message = "Registration Successful"
                if(!success){
                    message = error!.localizedDescription
                }
                let validationAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
                    if(success){
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                }
                
                validationAlert.addAction(alertAction)
                
                self.presentViewController(validationAlert, animated: true, completion: nil)
            })
        }else{
            return
        }
    }
    
    func validationAlert(message: String){
        let validationAlert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        validationAlert.addAction(alertAction)
        
        self.presentViewController(validationAlert, animated: true, completion: nil)
    }
    
}
