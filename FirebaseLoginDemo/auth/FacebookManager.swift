//
//  FacebookManager.swift
//  FirebaseLoginDemo
//
//  Created by Rasmus Nielsen on 03/04/2020.
//  Copyright © 2020 Rasmus Nielsen. All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore

class FacebookManager {
    
    let parentVC:ViewController
    
    init(parentVC:ViewController) {
        self.parentVC = parentVC
    }
    
    func loginToFacebook() {
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: self.parentVC) { (result) in
            print("logged in to facebook \(result)")
            
            switch result {
            case .cancelled :
                print("Login was cancelled")
                break
            case .failed(let error) :
                print("Login failed \(error.localizedDescription)")
                break
            case let .success(granted: _, declined: _, token: token) :
                print("Facebook login success \(token.userID)")
                // Log into Firebase using Facebook
                self.parentVC.firebaseManager?.signInUsingFacebook(tokenString: token.tokenString)
            }
        }
    }
    
    func makeGraphRequest() {
                if let tokenStr = AccessToken.current?.tokenString {
            let graphRequest = GraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email, picture"], tokenString: tokenStr, version: Settings.defaultGraphAPIVersion, httpMethod: .get)
            
            let connection = GraphRequestConnection()
            connection.add(graphRequest) { (connection, result, error) in
                if error == nil, let res = result {
                    var dict = res as! [String: Any] // Cast to dictionary
                    let name = dict["name"] as! String
                    print("Got data from Facebook! Name: \(name)")
                    print(dict)
                }
                else {
                    print("Error getting data from Facebook. \(error.debugDescription)")
                }
            }
            connection.start()
        }
    }
    
}
