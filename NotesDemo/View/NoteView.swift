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
    @ObservedObject var viewModel: NoteModel
    var body: some View {
        VStack {
            List{
                ForEach(self.viewModel.notes){ note in
                    NavigationLink(destination:NoteDetailView(title: note.name ?? "Unknown", text: note.content ?? "Unknown", folder:self.folder,id: note.id,viewModel: self.viewModel)){
                        Text(note.name ?? "Unknown")
                    }
                }.onDelete(perform: self.viewModel.removeNote)
            }
            .navigationBarTitle(self.folder.name ?? "Unknown")
            .navigationBarItems(trailing: Button(action:{
                
            }){
                NavigationLink(destination: NoteDetailView(folder: self.folder, viewModel: self.viewModel)){
                    Text("Nová poznámka")
                }
            }
            )
            
        }
        
    }
}
