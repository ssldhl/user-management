//
//  SignUpViewController.swift
//  User Management
//
//  Created by Sushil Dahal on 10/21/15.
//  Copyright © 2015 Sushil Dahal. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        profilePicture.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
