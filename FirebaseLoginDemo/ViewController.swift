//
//  ViewController.swift
//  FirebaseLoginDemo
//
//  Created by Rasmus Nielsen on 03/04/2020.
//  Copyright © 2020 Rasmus Nielsen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookCore
import FacebookLogin

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signedInField: UITextView!
    
    @IBOutlet weak var loggedInTextView: UITextView!
    
    
    @IBOutlet weak var signOutButton: UIButton!
    
    var firebaseManager:FirebaseManager?
    var facebookManager:FacebookManager?
    
    
    var auth = Auth.auth()  // Firebase authentication
    
    var loggedInVC = LoggedInViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager(parentVC: self)   // Enable firebaseManager to update GUI
        facebookManager = FacebookManager(parentVC: self);  // Enable Facebook to update GUI
    }

    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        // Verify that user has typed an email and password
        if let email = emailField.text, let password = passwordField.text {
            if firebaseManager!.validateEmail(candidate: email) && firebaseManager!.validatePassword(password: password){
                // If email and password is present, try to sign up.
                firebaseManager!.signUp(email: email, password: password)
            }
        }
    }
    
    @IBAction func SignInButtonPressed(_ sender: UIButton) {
        print("Sign in button pressed!")
        if let email = emailField.text, let password = passwordField.text {
            if firebaseManager!.validateEmail(candidate: email) && firebaseManager!.validatePassword(password: password){
                // If email and password is present, try to sign in.
                firebaseManager!.signIn(email: emailField.text!, password: passwordField.text!)
            }
        }
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
        do {
          try auth.signOut()
            print("\(auth.currentUser) logged out!")
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func facebookLoginPressed(_ sender: UIButton) {
        print("Facebook Login pressed")
        facebookManager?.loginToFacebook()
    }
    
    // Make Graph request for user data
    // In similar way, you can get user news feed
    @IBAction func loadFacebookDataPressed(_ sender: UIButton) {
        facebookManager?.makeGraphRequest()
    }

    func verify() -> (email:String, password:String, isOK:Bool) {
        if let email = emailField.text, let pwd = passwordField.text {
            if email.count > 5 && pwd.count > 5{
                return (email, pwd, true)
            }
        }
        return ("", "", false)
    }
}

