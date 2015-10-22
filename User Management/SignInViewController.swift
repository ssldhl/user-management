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
        
        if(emailAddress?.isEmpty ?? true || password?.isEmpty ?? true){
            print("Empty Fields")
            return
        }
        
        PFUser.logInWithUsernameInBackground(emailAddress!, password: password!) { (user:PFUser?, error:NSError?) -> Void in
            if(user != nil){
                let userName = user?.username
                NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "user_name")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let home:HomeViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
                let homeNavigation = UINavigationController(rootViewController: home)
                let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.rootViewController = homeNavigation
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

