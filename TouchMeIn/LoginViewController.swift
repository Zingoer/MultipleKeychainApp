/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext? = nil
    let MyKeychainWrapper = KeychainItemWrapper()
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createInfoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.
        let hasLogin = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
        
        // 2.
        if hasLogin {
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            loginButton.tag = loginButtonTag
            createInfoLabel.hidden = true
        } else {
            loginButton.setTitle("Create", forState: UIControlState.Normal)
            loginButton.tag = createLoginButtonTag
            createInfoLabel.hidden = false
        }
        
        // 3.
        if let storedUsername = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String {
            usernameTextField.text = storedUsername as String
        }
    }
    
    // MARK: - Action for checking username/password
    @IBAction func loginAction(sender: AnyObject) {
        
        // 1.If either the username or password is empty, then present an alert to the user and return from the method
        if (usernameTextField.text == "" || passwordTextField.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                message: "Wrong username or password." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Foiled Again!", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
        
        // 2.Dismiss the keyboard if it’s visible.
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        // 3.If the login button’s tag is createLoginButtonTag, then proceed to create a new login.
        if sender.tag == createLoginButtonTag {
            
            // 4.Next, you read hasLoginKey from NSUserDefaults which indicates whether a password has been saved to the Keychain. If the username field is not empty and hasLoginKey indicates no login has already been saved, then you save the username to NSUserDefaults.
            let hasLoginKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
            if hasLoginKey == false {
                NSUserDefaults.standardUserDefaults().setValue(self.usernameTextField.text, forKey: "username")
            }
            
            // 5.You then use mySetObject and writeToKeychain to save the password text to Keychain. You then set hasLoginKey in NSUserDefaults to true to indicate that a password has been saved to the keychain. You set the login button’s tag to loginButtonTag so that it will prompt the user to log in the next time they run your app, rather than prompting the user to create a login. Finally, you dismiss loginView.
//            MyKeychainWrapper.mySetObject(passwordTextField.text, forKey:kSecValueData)
//            MyKeychainWrapper.writeToKeychain()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasLoginKey")
            NSUserDefaults.standardUserDefaults().synchronize()
            loginButton.tag = loginButtonTag
            
            performSegueWithIdentifier("dismissLogin", sender: self)
        } else if sender.tag == loginButtonTag {
            // 6.If the user is logging in (as indicated by loginButtonTag), you call checkLogin(_:password:) to verify the user-provided credentials; if they match then you dismiss the login view.
            if checkLogin(usernameTextField.text!, password: passwordTextField.text!) {
                performSegueWithIdentifier("dismissLogin", sender: self)
            } else {
                // 7.If the login authentication fails, then present an alert message to the user.
                let alertView = UIAlertController(title: "Login Problem",
                    message: "Wrong username or password." as String, preferredStyle:.Alert)
                let okAction = UIAlertAction(title: "Foiled Again!", style: .Default, handler: nil)
                alertView.addAction(okAction)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }
    
    func checkLogin(username: String, password: String ) -> Bool {
//        if password == MyKeychainWrapper.myObjectForKey(kSecValueData) as? String && username == NSUserDefaults.standardUserDefaults().valueForKey("username") as? String{
//            return true
//        }else{
//            return false
//        }
        return false
    }
    
    
    
}
