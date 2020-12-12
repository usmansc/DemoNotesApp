//
//  NoteModel.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 12/12/2020.
//

import Foundation
import CoreData

extension NoteView{
    final class NoteModel:NSObject, ObservableObject, NSFetchedResultsControllerDelegate{
        private let controller :  NSFetchedResultsController<Note>
        
        init(moc: NSManagedObjectContext,folder: Folder) {
            let sortDescriptors = [NSSortDescriptor(keyPath: \Note.date, ascending: true)]
            
            controller = Note.resultsController(moc: moc, sortDescriptors: sortDescriptors,predicate: NSPredicate(format: "is_in = %@",folder))
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
        
        var notes: [Note] {
            return controller.fetchedObjects ?? []
        }
        
        func addNewNote(name: String,text: String, folder:Folder,id: UUID?){
            if let id = id{
                let note = notes.filter({$0.id == id}).map({return $0})
                if(note.count != 0) {
                    note[0].content = text
                    note[0].name = name
                    note[0].date = Date()
                }
            }else{
                let note = Note(context: controller.managedObjectContext)
                note.content = text
                note.name = name
                note.date = Date()
                note.id = UUID()
                note.is_in = folder
            }
            
            saveContext()
        }
        
        func removeNote(_ indexSet: IndexSet){
            indexSet.map{notes[$0]}.forEach(controller.managedObjectContext.delete)
            saveContext()
        }
        
        func saveContext(){
            do{
                try controller.managedObjectContext.save()
            }catch {
                print("TODO Proper errror handling")
            }
        }
    }
}
