//
//  HomeViewController.swift
//  User Management
//
//  Created by Sushil Dahal on 10/22/15.
//  Copyright © 2015 Sushil Dahal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menu(sender: UIBarButtonItem) {
        appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Left
            , animated: true, completion: nil)
    }
    
    @IBAction func options(sender: UIBarButtonItem) {
        appDelegate.drawerContainer?.toggleDrawerSide(MMDrawerSide.Right
            , animated: true, completion: nil)
    }
}
