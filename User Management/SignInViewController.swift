//
//  SignInViewController.swift
//  User Management
//
//  Created by Sushil Dahal on 10/21/15.
//  Copyright © 2015 Sushil Dahal. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(sender: UIButton) {
        let emailAddress = emailAddressField.text
        let password = passwordField.text
        
        self.view.endEditing(true)
        
        if(emailAddress!.isEmpty || password!.isEmpty){
            print("Empty Fields")
            return
        }
        
        let spinner = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
        spinner.labelText = "Please Wait"
        
//        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50)) as UIActivityIndicatorView
//        spinner.center = self.view.center
//        spinner.hidesWhenStopped = true
//        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//        self.view.addSubview(spinner)
//        spinner.startAnimating()
        
        PFUser.logInWithUsernameInBackground(emailAddress!, password: password!) { (user:PFUser?, error:NSError?) -> Void in
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
//            spinner.stopAnimating()
            
            if(user != nil){
                let userName = user?.username
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.buildUI()
            }else{
                let message = error!.localizedDescription
                let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                
                let alertButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil)
                
                alert.addAction(alertButton)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }

}

