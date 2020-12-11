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

    @NSManaged public var name: String?
    @NSManaged public var contains: Note?

}

extension Folder : Identifiable {

}
