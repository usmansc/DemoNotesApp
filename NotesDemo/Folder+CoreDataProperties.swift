//
//  Folder+CoreDataProperties.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 11/12/2020.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }
    
    @nonobjc public class func resultsController(moc: NSManagedObjectContext, sortDescriptors: [NSSortDescriptor]) -> NSFetchedResultsController<Folder> {
        let request =  NSFetchRequest<Folder>(entityName: "Folder")
        request.sortDescriptors = sortDescriptors
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
    }

    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var contains: NSSet?
    
    
    public var wContains: [Note]{
        let notes = contains as? Set<Note> ?? []
        return notes.sorted(by: {firstNote, secondNote -> Bool in
            return firstNote.date < secondNote.date
            })
    }

}

// MARK: Generated accessors for contains
extension Folder {

    @objc(addContainsObject:)
    @NSManaged public func addToContains(_ value: Note)

    @objc(removeContainsObject:)
    @NSManaged public func removeFromContains(_ value: Note)

    @objc(addContains:)
    @NSManaged public func addToContains(_ values: NSSet)

    @objc(removeContains:)
    @NSManaged public func removeFromContains(_ values: NSSet)

}

extension Folder : Identifiable {

}
