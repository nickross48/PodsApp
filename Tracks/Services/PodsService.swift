//
//  PodsService.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-16.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth.FIRUser

struct PodsService {
    static func createPods (_ firUser: FIRUser, podName: String, completion: @escaping (Pods?) -> Void) {
        
        let podAttrs = ["podName": podName]
        
        
        let ref = Database.database().reference().child("pods").child(firUser.uid)
        ref.setValue(podAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let pods = Pods(snapshot: snapshot)
                completion(pods)
            })
        }
        
        
        
        
    }
    
}


// from UserService.swift
//static func create(_ firUser: FIRUser, name: String, email: String, completion: @escaping (User?) -> Void) {
//    // let userAttrs = User.userDict
//
//    let userAttrs = ["name": name, "email": email]
//
//
//    let ref = Database.database().reference().child("users").child(firUser.uid)
//    ref.setValue(userAttrs) { (error, ref) in
//        if let error = error {
//            assertionFailure(error.localizedDescription)
//            return completion(nil)
//        }
//
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            let user = User(snapshot: snapshot)
//            completion(user)
//        })
//    }
//}

