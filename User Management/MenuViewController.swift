//
//  MenuViewController.swift
//  User Management
//
//  Created by Sushil Dahal on 10/22/15.
//  Copyright © 2015 Sushil Dahal. All rights reserved.
//

import UIKit
import Parse

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var menuItems: [String] = ["Main", "About", "Sign Out"]
    
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var nameField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let firstName: String = PFUser.currentUser()?.objectForKey("first_name") as! String
        let lastName: String = PFUser.currentUser()?.objectForKey("last_name") as! String
        nameField.text = "\(firstName) \(lastName)"
        
        let profilePictureData: PFFile = PFUser.currentUser()?.objectForKey("profile_picture") as! PFFile
        profilePictureData.getDataInBackgroundWithBlock { (profilePicture:NSData?, error:NSError?) -> Void in
            if(profilePicture != nil){
                self.profilePictureView.image = UIImage(data: profilePicture!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let menuTableCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("menuTableCell", forIndexPath: indexPath)
        menuTableCell.textLabel?.text = menuItems[indexPath.row]
        return menuTableCell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        switch(indexPath.row){
        case 0:
            let home: HomeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            let homeNavigation = UINavigationController(rootViewController: home)
            
            appDelegate.drawerContainer?.centerViewController = homeNavigation
            appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            break
        case 1:
            let about: AboutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
            let aboutNavigation = UINavigationController(rootViewController: about)
            
            appDelegate.drawerContainer?.centerViewController = aboutNavigation
            appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            
            break
        case 2:
            NSUserDefaults.standardUserDefaults().removeObjectForKey("user_name")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let spinner = MBProgressHUD.showHUDAddedTo(self.view, animated:true)
            spinner.labelText = "Please Wait"
            
            PFUser.logOutInBackgroundWithBlock({ (error:NSError?) -> Void in
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                if(error == nil){
                    let signIn: SignInViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SignInViewController") as! SignInViewController
                    let signInNavigation = UINavigationController(rootViewController: signIn)
                    appDelegate.window?.rootViewController = signInNavigation
                }else{
                    print(error!.localizedDescription)
                }
            })
            
            break
        default:
            print("This case will not arrive")
        }
    }

}
