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
    var body: some View {
        VStack {
            List{
                ForEach(self.folder.wContains){ note in
                    NavigationLink(destination:NoteDetailView(title: note.name ?? "Unknown", text: note.content ?? "Unknown", folder:self.folder,id: note.id)){
                        Text(note.name ?? "Unknown")
                    }
                }
            }
            .navigationBarTitle(self.folder.name ?? "Unknown")
            .navigationBarItems(trailing: Button(action:{
                
            }){
                NavigationLink(destination: NoteDetailView(folder: self.folder)){
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
