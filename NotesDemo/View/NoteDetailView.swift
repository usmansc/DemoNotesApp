//
//  NoteDetailView.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 11/12/2020.
//

import SwiftUI
import CoreData

struct NoteDetailView: View {
    @State var title: String = "" // nazov poznamky
    @State var text: String = "" // text poznamky
    var folder: Folder // aktualny priecinok
    @Environment(\.managedObjectContext) private var viewContext
    var id: UUID? // id poznamky , iba ak poznamku editujeme
    @ObservedObject var viewModel: NoteView.NoteModel // viewModel spravujuci poznamky
    var body: some View {
        VStack{
            TextField("Názov", text: $title).font(.title)
            Divider()
            MultiLineTextField(text: $text)
            }.padding().navigationBarItems(trailing: Button(action:{
                self.viewModel.addNewNote(name: title, text: text, folder: folder,id: id)
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
            }){Text("Uložiť zmeny")})
        .alert(isPresented: self.$viewModel.alert){
            Alert(title: Text("Chyba"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("Rozumiem")))
        }
    }
}
