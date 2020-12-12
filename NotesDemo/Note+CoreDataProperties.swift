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

    @nonobjc public class func resultsController(moc: NSManagedObjectContext, sortDescriptors: [NSSortDescriptor],predicate: NSPredicate) -> NSFetchedResultsController<Note> {
        let request =  NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = sortDescriptors
        request.predicate = predicate
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
    }
    @NSManaged public var name: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date
    @NSManaged public var id: UUID?
    @NSManaged public var is_in: Folder?

}

extension Note : Identifiable {

}
