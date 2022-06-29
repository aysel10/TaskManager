//
//  PersistenceController.swift
//  TaskManager
//
//  Created by Aysel on 6/28/22.
//

import Foundation

import CoreData

class PersistenceController: ObservableObject {
    //MARK: - Properties
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    //MARK: - Initializer
    init() {
        container = NSPersistentContainer(name: "TasksContainer")

        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolve Error: \(error)")
            }
        }
    }
}
