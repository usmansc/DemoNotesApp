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
    var changed : UUID // Salt change to make swiftui update foreach in pointing view
    var body: some View {
        VStack{
            TextField("Názov", text: $title).font(.title)
            Divider()
            MultiLineTextField(text: $text)
            }.padding().navigationBarItems(trailing: Button(action:{
                if let id = id{
                    let note = self.folder.wContains.filter({$0.id == id}).map({return $0})
                    if(note.count != 0) {
                        note[0].content = self.text
                        note[0].name = self.title
                        note[0].date = Date()
                        
                        do{
                            try self.viewContext.save()
                        }catch{
                            print("TODO err")
                        }
                        
                    }
                }else{
                    do{
                        let note = Note(context: self.viewContext)
                        note.content = self.text
                        note.name = self.title
                        note.date = Date()
                        note.id = UUID()
                        note.is_in = self.folder
                        try self.viewContext.save()
                    }catch{
                        print("TODO: Handle err")
                    }
                }

                
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                
            }){Text("Uložiť zmeny")})
    }
}
