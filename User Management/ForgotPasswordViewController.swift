//
//  ForgotPasswordViewController.swift
//  User Management
//
//  Created by Sushil Dahal on 10/23/15.
//  Copyright © 2015 Sushil Dahal. All rights reserved.
//

import UIKit
import Parse

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailAddressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send(sender: UIButton) {
        let emailAddress = emailAddressField.text
        self.view.endEditing(true)
        
        if(emailAddress?.isEmpty ?? true){
            displayAlert("Email Address is required", dismiss: false)
            return
        }
        
        let spinner = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
        spinner.labelText = "Please Wait"
        
        PFUser.requestPasswordResetForEmailInBackground(emailAddress!) { (success:Bool, error:NSError?) -> Void in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            if(success){
                self.displayAlert("An email has been sent with password reset instructions at \(emailAddress!)", dismiss: true)
            }else{
                self.displayAlert(error!.localizedDescription, dismiss: false)
            }
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
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
