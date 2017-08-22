//
//  PodsService.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-16.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth.FIRUser

struct PodsService{
    
    static func create(podName: String, completion: @escaping(String) -> Void) {
        
        let userAttrs = ["podName": podName] as [String : Any]
        
        let ref = Database.database().reference().child("users").child(User.current.uid).child("pods").childByAutoId()
        ref.updateChildValues(userAttrs) { (error, ref)  in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
            completion(ref.key)
        }
        
        /*
         let locref = ref.child("location")
         locref.setValue(location.dictValue) { (error, locref) in
         if let error = error {
         assertionFailure(error.localizedDescription)
         return completion(ref.key)
         }
         }
         */
        
        
    }
    

    
    static func retrievePods(userID: String, completion: @escaping ([Pods]?) -> Void) {
        
        let ref = Database.database().reference().child("users").child(User.current.uid).child("pods")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshotArray = snapshot.children.allObjects as? [DataSnapshot]
                else {
                    return completion(nil)
            }
            
            var arrayOfPods = [Pods]()
            
            for podSnapshot in snapshotArray {
                guard let pod = Pods(snapshot: podSnapshot)
                    else { return completion([]) }
                
                arrayOfPods.append(pod)
            }
            completion(arrayOfPods)
            
            
        })
    }
    
}


/*
 import Foundation
 import FirebaseDatabase
 import FirebaseAuth.FIRUser
 
 struct PodsService {
 static func createPods (pid: String, podName: String, completion: @escaping (Pods?) -> Void) {
 
 let podAttrs = ["podName": podName]
 
 let ref = Database.database().reference().child("pods").childByAutoId()
 let pid = ref.key
 
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
 */




// let ref = Database.database().reference().child("pods").child(firUser.uid)


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



//    static func show(forKey depKey: String, posterUID: String, completion: @escaping (Pods?) -> Void) {
//
//        let ref = Database.database().reference().child("users").child(User.current.uid).child("pods").child(depKey)
//
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let deposit = Pods(snapshot: snapshot) else {
//                return completion(nil)
//            }
//            completion(deposit)
//        })
//    }

