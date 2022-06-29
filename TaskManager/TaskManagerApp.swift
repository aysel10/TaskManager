//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Aysel on 6/28/22.
//

import SwiftUI
import CoreData

@main
struct TaskManagerApp: App {
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            
            ContentView().environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
