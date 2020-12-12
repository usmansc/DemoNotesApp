//
//  FolderModel.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 12/12/2020.
//

import Foundation
import CoreData

extension FolderView{
    final class FolderModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate{
        private let controller :  NSFetchedResultsController<Folder>
        
        init(moc: NSManagedObjectContext) {
            let sortDescriptors = [NSSortDescriptor(keyPath: \Folder.name, ascending: true)]
            controller = Folder.resultsController(moc: moc, sortDescriptors: sortDescriptors)
            super.init()
            
            controller.delegate = self
            do{
                try controller.performFetch()
            }catch{
                print("Err handle here")
            }
        }
        
        func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            objectWillChange.send()
        }
        
        func addNewFolder(name: String){
            if(name.count > 0){
                let folder = Folder(context: controller.managedObjectContext)
                folder.name = name
                folder.date = Date()
                saveContext()
            }
        }
        
        func removeFolder(_ indexSet: IndexSet){
            indexSet.map{folders[$0]}.forEach(controller.managedObjectContext.delete)
            saveContext()
        }
        
        func saveContext(){
            do{
                try controller.managedObjectContext.save()
            }catch {
                print("TODO Proper errror handling")
            }
        }
        
        var folders: [Folder] {
            return controller.fetchedObjects ?? []
        }
        
    }
}

