//
//  NoteDetailView.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 11/12/2020.
//

import SwiftUI
import CoreData

struct NoteDetailView: View {
    @State var title: String = ""
    @State var text: String = ""
    var folder: Folder
    @Environment(\.managedObjectContext) private var viewContext
    var id: UUID?
    @ObservedObject var viewModel: NoteView.NoteModel
    var body: some View {
        VStack{
            TextField("Názov", text: $title).font(.title)
            Divider()
            MultiLineTextField(text: $text)
            }.padding().navigationBarItems(trailing: Button(action:{
                self.viewModel.addNewNote(name: title, text: text, folder: folder,id: id)
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
            }){Text("Uložiť zmeny")})
    }
}
