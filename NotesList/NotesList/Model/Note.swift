//
//  Note.swift
//  Notes List
//
//  Created by Oleg Tsarenkoff on 8.08.21.
//

import CoreData

@objc (Note)
class Note: NSManagedObject{
    @NSManaged var noteId: NSNumber!
    @NSManaged var noteTitle: String!
    @NSManaged var noteDescription: String!
    @NSManaged var noteDeleted: Date?
}
