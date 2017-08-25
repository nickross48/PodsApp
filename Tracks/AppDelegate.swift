//
//  AppDelegate.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-02.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import UIKit
import Firebase
import CoreData
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        IQKeyboardManager.sharedManager().enable = true

        let defaults = UserDefaults.standard
        let initialViewController: UIViewController
        
        if Auth.auth().currentUser != nil,
            let userData = defaults.object(forKey: Constants.UserDefaults.currentUser) as? Data,
            let user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User {
            
            User.setCurrent(user)
            
            initialViewController = UIStoryboard.initialViewController(for: .main)
        }  else {
            initialViewController = UIStoryboard.initialViewController(for: .login)
        }
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()

//        // create an instance of login storyboard that has loginVC set as initial VC
//        let storyboard = UIStoryboard(name: "Login", bundle: .main)
//        
//        // check if storyboard has an initial VC set
//        if let initialViewController = storyboard.instantiateInitialViewController() {
//            // if storyboard's initial VC exists set it to the window's rootVC property
//            window?.rootViewController = initialViewController
//            // position window above other existing windows
//            window?.makeKeyAndVisible()
//        }
        
        return true
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MakePods")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()



}

// <a href="https://icons8.com/icon/24717/Add">Add icon credits</a> l
// link for add icon

// <a href="https://icons8.com/icon/14095/Lock">Lock icon credits</a>
// link for lock icon


// <a href="https://icons8.com/icon/14099/Settings">Settings icon credits</a>
// link for settings

// <a href="https://icons8.com/icon/15/Bar-Chart">Bar chart icon credits</a>
// link for chart icon

//<a href="https://icons8.com/icon/14096/Home">Home icon credits</a>
// link for home icon

// <a href="https://icons8.com/icon/26217/Logout-Rounded-Left-Filled">Logout rounded left filled icon credits</a>
// link for logout button
