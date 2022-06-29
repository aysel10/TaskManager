//
//  Task+CoreDataProperties.swift
//  TaskManager
//
//  Created by Aysel on 6/28/22.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var title: String?
    @NSManaged public var desciption: String?
    @NSManaged public var date: Date?
    @NSManaged public var comments: NSSet?

    public var wrappedTitle: String {
        title ?? "Unknown Task"
    }
    
    public var wrappedDescription: String {
        desciption ?? "Unknown Task Description"
    }
    
    public var wrappedDate: Date {
        date ?? Date.now
    }
    
    public var commentArray: [Comment]{
        let set = comments as? Set<Comment> ?? []
        
        return set.sorted{
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for comments
extension Task {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

extension Task : Identifiable {

}
