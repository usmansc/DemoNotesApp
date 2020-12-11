//
//  NoteView.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 11/12/2020.
//

import SwiftUI

struct NoteView: View {
    var folder: Folder
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest var notes: FetchedResults <Note>
    init(folder:Folder) {
        self.folder = folder
        
        self._notes = FetchRequest(entity: Note.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Note.date, ascending: true)], predicate: NSPredicate(format: "is_in = %@",folder))
    }
    var body: some View {
        VStack {
            List{
                ForEach(notes){ note in
                    NavigationLink(destination:NoteDetailView(title: note.name ?? "Unknown", text: note.content ?? "Unknown", folder:self.folder,id: note.id,changed: UUID())){
                        Text(note.name ?? "Unknown")
                    }
                }
            }
            .navigationBarTitle(self.folder.name ?? "Unknown")
            .navigationBarItems(trailing: Button(action:{
                
            }){
                NavigationLink(destination: NoteDetailView(folder: self.folder, changed: UUID())){
                    Text("Nová poznámka")
                }
            }
            )
            
        }
        
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(folder: Folder())
    }
    

}
