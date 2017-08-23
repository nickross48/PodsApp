//
//  UserService.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-02.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth.FIRUser

struct UserService {
    
    static func create(_ firUser: FIRUser, name: String, email: String, completion: @escaping (User?) -> Void) {
        // let userAttrs = User.userDict
        
        let userAttrs = ["name": name, "email": email]
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("Users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
}







/*
 static func create(_ firUser: FIRUser, name: String, completion: @escaping (User?) -> Void) {
 let userAttrs = ["name": name]
 
 let ref = Database.database().reference().child("users").child(firUser.uid)
 ref.setValue(userAttrs) { (error, ref) in
 if let error = error {
 assertionFailure(error.localizedDescription)
 return completion(nil)
 }
 
 ref.observeSingleEvent(of: .value, with: { (snapshot) in
 let user = User(snapshot: snapshot)
 completion(user)
 })
 }
 }
 */
