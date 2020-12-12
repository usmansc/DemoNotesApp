//
//  FolderModel.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 12/12/2020.
//

import Foundation
import CoreData
import SwiftUI

extension FolderView{
    final class FolderModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate{ // viewModel pre spravovanie priecinkov
        private let controller :  NSFetchedResultsController<Folder>
        // pre chybove hlasky
        public var alert = false
        public var alertMessage = ""
        init(moc: NSManagedObjectContext) {
            let sortDescriptors = [NSSortDescriptor(keyPath: \Folder.name, ascending: true)]
            controller = Folder.resultsController(moc: moc, sortDescriptors: sortDescriptors)
            super.init()
            
            controller.delegate = self
            do{
                try controller.performFetch()
                alert = false
            }catch{
                alert =  true
                alertMessage = "Chyba pri načítaní priečinkov"
            }
        }
        
        func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            objectWillChange.send()
        }
        // Vytvorenie priecinka
        func addNewFolder(name: String){
            if(name.count > 0){ // Ak nie je nazov priecinku prazdny pokracujeme
                let folder = Folder(context: controller.managedObjectContext)
                folder.name = name
                folder.date = Date()
                saveContext()
            }
        }
        // Zmazanie priecinka
        func removeFolder(_ indexSet: IndexSet){
            indexSet.map{folders[$0]}.forEach(controller.managedObjectContext.delete)
            saveContext()
        }
        
        // Ulozenie do CD
        func saveContext(){
            do{
                try controller.managedObjectContext.save()
                alert = false
            }catch {
                alert =  true
                alertMessage = "Chyba pri ukladaní priečinkov"
            }
        }
        
        var folders: [Folder] {
            return controller.fetchedObjects ?? []
        }
        
    }
}

