//
//  UserIdentityViewController.swift
//  MySampleApp
//
//
// Copyright 2016 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-swift v0.4
//

import Foundation
import UIKit
import AWSMobileHubHelper
import AWSCognitoIdentityProvider

class UserProfileViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var userEmailAddress: UILabel!
    @IBOutlet weak var userLastName: UILabel!
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Editing Mode is off
        /*self.setEditing(false, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: (self.editing) ? .Done : .Edit, target: self, action: #selector(UserProfileViewController.enableEditingMode))
        */
        
        
        let identityManager = AWSIdentityManager.defaultIdentityManager()
        
        // Load username to profile
        if let identityUserName = identityManager.userName {
            userEmailAddress.text = identityUserName
        } else {
            userEmailAddress.text = NSLocalizedString("Error Reading Identity", comment: "Placeholder text for the guest user.")
        }
        
        
        // Load user img to profile
        //userID.text = identityManager.identityId
        userID.text = defaults.stringForKey("Lastname")! + ", " + defaults.stringForKey("Firstname")!
        
        if let imageURL = identityManager.imageURL {
            let imageData = NSData(contentsOfURL: imageURL)!
            if let profileImage = UIImage(data: imageData) {
                userImageView.image = profileImage
            } else {
                userImageView.image = UIImage(named: "UserIcon")
            }
        }
        
        //userLastName.text = identityManager.
        
        //TODO
        // Load email address to user profile
        //userEmailAddress.text = identityManager.e
        
    }
    
    
    
    @IBAction func enableEditingMode() {
        
        if(!self.editing){
            print("Edit Button Pressed")
            self.setEditing(true, animated: true)
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(UserProfileViewController.cancelEdit))
            print("Edit Finished")
        }else{
            print("Done Button Pressed")
            self.setEditing(false, animated: true)
            print("Done Finished")
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: (self.editing) ? .Done : .Edit, target: self, action: #selector(UserProfileViewController.enableEditingMode))
    }
    
    @IBAction func cancelEdit(){
        print("Cancel Button Pressed")
        viewWillAppear(true)
    }
    
    @IBAction func Settings(sender: UIButton) {
        let storyboard = UIStoryboard(name: "UserSettings", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("UserSettings")
        navigationController!.pushViewController(viewController, animated: true)
    }
    /* Abandon
     func getProfile(){
     
     
     let objectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
     let queryExpression = AWSDynamoDBQueryExpression()
     queryExpression.keyConditionExpression = "#hashAttribute = :hashAttributeWithComplexName"
     queryExpression.expressionAttributeNames = ["#hashAttribute": "EmailAddress"]
     queryExpression.expressionAttributeValues = [":hashAttribute": "xu.1487"]
     
     
     objectMapper.query(UserProfileTableRow.self, expression: queryExpression) .continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) in
     if (task.error == nil) {
     if (task.result != nil) {
     let tableRow = task.result as! UserProfileTableRow
     
     self.userEmailAddress.text = tableRow.EmailAddress
     }
     }
     else {
     self.userEmailAddress.text = task.error.debugDescription
     }
     return nil
     })
     }
     */
}
