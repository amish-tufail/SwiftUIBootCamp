//
//  CoreDataRelationshipManager.swift
//  SwiftUIBootCamp
//
//  Created by Amish on 26/04/2024.
//

import Foundation
import CoreData

class CoreDataRelationshipManager {
    static let shared = CoreDataRelationshipManager()
    let container: NSPersistentContainer
    let context:  NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            } else {
                print("Successfully loaded core data.")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving core data: \(error.localizedDescription)")
        }
    }
}
