//
//  Pods.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-15.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot
import CoreData

class Pods: NSObject {
    
    // MARK: - Properties
    
    let pid: String
    let podName: String
    
    var dictValue: [String : Any] {
        return [ "podName": podName]
    }
    
    
    // MARK: - Init
    
    init(pid: String, podName: String) {
        self.pid = pid
        self.podName = podName
        super.init()
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let podName = dict["podName"] as? String
            else { return nil }
        
        self.pid = snapshot.key
        self.podName = podName
        
        super.init()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        guard let pid = aDecoder.decodeObject(forKey: Constants.PodDefaults.pid) as? String,
            let podName = aDecoder.decodeObject(forKey: Constants.PodDefaults.podName) as? String
            else { return nil }
        
        self.pid = pid
        self.podName = podName
        
        super.init()
    }
    
}

extension Pods: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(pid, forKey: Constants.PodDefaults.pid)
        aCoder.encode(podName, forKey: Constants.PodDefaults.podName)
    }
}







/*
 // MARK: - Singleton
 // do we need the singleton?
 
 // 1
 private static var _current: User?
 
 // 2
 static var current: User {
 // 3
 guard let currentUser = _current else {
 fatalError("Error: current user doesn't exist")
 }
 
 // 4
 return currentUser
 }
 
 // MARK: - Class Methods
 // do we need the class methods?
 
 // 1
 class func setCurrent(_ User: User, writeToUserDefaults: Bool = false) {
 // 2
 if writeToUserDefaults {
 // 3
 let data = NSKeyedArchiver.archivedData(withRootObject: User)
 
 // 4
 UserDefaults.standard.set(data, forKey: Constants.PodDefaults.currentUser)
 }
 
 _current = User
 }
 */
