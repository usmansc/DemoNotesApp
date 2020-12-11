//
//  NoteDetailView.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 11/12/2020.
//

import SwiftUI

struct NoteDetailView: View {
    @State var title: String = ""
    @State var text: String = ""
    var folder: Folder
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        VStack{
            TextField("Názov", text: $title).font(.title)
            Divider()
            MultiLineTextField(text: $text)
            }.padding().navigationBarItems(trailing: Button(action:{
                //self.notesModel.addNote(name: self.title, id: self.id, text: self.text,folder:self.folder)
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
            }){Text("Uložiť zmeny")})
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView(folder: Folder())
    }
}
