//
//  CoreDataHelper.swift
//  Tracks
//
//  Created by Nicholas Ross on 2017-08-23.
//  Copyright © 2017 Nicholas Ross. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
    static func newPodEntry() -> PodEntry {
        let podEntry = NSEntityDescription.insertNewObject(forEntityName: "PodEntry", into: managedContext) as! PodEntry
        return podEntry
    }
    
    static func savePodEntry() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func delete(podEntry: PodEntry) {
        managedContext.delete(podEntry)
        savePodEntry()
    }
    
    static func retrievePodEntry() -> [PodEntry] {
        let fetchRequest = NSFetchRequest<PodEntry>(entityName: "Pods")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
    
    static func savePodAmount(podName: String, podValue: Double) {
        do {
            
        }
    }
    
}
