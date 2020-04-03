//
//  FirebaseManager.swift
//  FirebaseLoginDemo
//
//  Created by Rasmus Nielsen on 03/04/2020.
//  Copyright © 2020 Rasmus Nielsen. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    
    let auth = Auth.auth()
    let parentVC:ViewController
    
    init(parentVC:ViewController) {
        self.parentVC = parentVC
        // Add listener
        auth.addIDTokenDidChangeListener { (auth, user) in
            if user != nil {
                print("Status: User is logged in: \(user)")
                //parentVC.loggedInTextView.text = "You are now logged in!"
            }
            else {
                print("Status: User is logged out")
            }
        }
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("User logged in")
                self.parentVC.performSegue(withIdentifier: "loggedIn", sender: self)
            }
            else {
                print("Error encountered while signing in")
                self.parentVC.performSegue(withIdentifier: "loggedIn", sender: self)
            }
            
        }
    }
    
    // Get credentials from Facebook and use them to log into Firebase.
    func signInUsingFacebook(tokenString:String) {
        // Call Firebase using credentials from Facebook
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
        auth.signIn(with: credential) { (result, error) in
            if error == nil {
                print("Logged in to Firebase, using Facebook \(result.debugDescription)")
            }
            else {
                print("Failed to log in to Firebase, using Facebook \(error.debugDescription)")
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {   // No error encountered during sign up
                print("Successfully logged in to Firebase! \(result.debugDescription)")
            }
            else {
                print("Failed to log in to Firebase. \(error.debugDescription)")
            }
        }
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    func validatePassword(password: String) -> Bool {
        return password.count > 5
    }
    
}
