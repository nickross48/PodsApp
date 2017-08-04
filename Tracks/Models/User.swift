//
//  User.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-02.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User: NSObject {
    
    // MARK: - Properties
    
    let uid: String
    let name: String
    let email: String
    
    var dictValue: [String : Any] {
        return [ "name": name,
                "email" : email]
    }
    
    
    // MARK: - Init
    
    init(uid: String, name: String, email: String) {
        self.uid = uid
        self.name = name
        self.email = email
        super.init()
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let name = dict["name"] as? String,
            let email = dict["email"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.name = name
        self.email = email
        
        super.init()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let name = aDecoder.decodeObject(forKey: Constants.UserDefaults.name) as? String,
            let email = aDecoder.decodeObject(forKey: Constants.UserDefaults.email) as? String
            else { return nil }
        
        self.uid = uid
        self.name = name
        self.email = email
        
        super.init()
    }
    
    // MARK: - Singleton
    
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
    
    // 1
    class func setCurrent(_ User: User, writeToUserDefaults: Bool = false) {
        // 2
        if writeToUserDefaults {
            // 3
            let data = NSKeyedArchiver.archivedData(withRootObject: User)
            
            // 4
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
        }
        
        _current = User
    }
}

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(name, forKey:Constants.UserDefaults.name)
        aCoder.encode(email, forKey: Constants.UserDefaults.email)
    }
}
