//
//  LoggedInViewController.swift
//  FirebaseLoginDemo
//
//  Created by Rasmus Nielsen on 03/04/2020.
//  Copyright © 2020 Rasmus Nielsen. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoggedInViewController: UIViewController {

    @IBOutlet weak var loggedInTextView: UITextView!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    var auth = Auth.auth()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if auth.currentUser != nil {
            loggedInTextView.text = "You successfully logged in!"
        }
        else {
            // Hide the sign out button, since
            // sign in failed.
            signOutButton.isHidden = true
            loggedInTextView.text = "Wrong email or password, mate!"
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
        do {
          try auth.signOut()
            print("\(auth.currentUser) logged out!")
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
          
        
    }
    
}
