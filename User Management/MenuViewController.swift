//
//  MenuViewController.swift
//  User Management
//
//  Created by Sushil Dahal on 10/22/15.
//  Copyright © 2015 Sushil Dahal. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource {

    var menuItems: [String] = ["Main", "About", "Sign Out"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    

}
