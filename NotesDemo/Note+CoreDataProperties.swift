//
//  Note+CoreDataProperties.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 11/12/2020.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var name: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var is_in: Folder?

}

extension Note : Identifiable {

}
