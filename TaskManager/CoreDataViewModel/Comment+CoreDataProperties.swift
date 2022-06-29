//
//  Comment+CoreDataProperties.swift
//  TaskManager
//
//  Created by Aysel on 6/28/22.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var name: String?
    @NSManaged public var task: Task?

    public var wrappedName: String {
        name ?? "Unknown Task"
    }
}

extension Comment : Identifiable {

}
