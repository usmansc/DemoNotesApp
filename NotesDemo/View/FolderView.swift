//
//  FolderView.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 11/12/2020.
//

import SwiftUI

struct FolderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Folder.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Folder.name, ascending: true)]) var folders : FetchedResults <Folder>
    
    @State private var alert = false
    
    var body: some View {
        NavigationView{
            ZStack {
                List{
                    ForEach(folders){ folder in
                        Text(folder.name ?? "Unknown")
                    }
                }
                .navigationBarTitle("Priečinky")
                .disabled(self.alert)
                .navigationBarItems(trailing:
                                        Button(action: {
                                            self.alert.toggle()
                                        }){
                                            self.alert ? Text("Zavrieť") : Text("Nový priečinok")
                                        })
                if(alert){
                    VStack{
                        NewFolderAlert(shown: self.$alert).environment(\.managedObjectContext, self.viewContext)
                            .frame(width: 300, height: 200, alignment: .center).background(Color.black).cornerRadius(30)
                        Spacer()
                    }.padding()
                    
                }
                
            }
        }
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}

struct NewFolderAlert: View{
    @State private var text = ""
    @Binding<Bool> var shown: Bool
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View{
        VStack{
            Text("Nový priečinok").foregroundColor(.white)
            Text("Zadajte názov pre tento priečinok").foregroundColor(.white)
            TextField("Názov", text: $text).padding().foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray))
            Button(action: {
                self.shown.toggle()
                let trimmed = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
                if(trimmed.count > 0){
                    do{
                        let folder = Folder(context: self.viewContext)
                        folder.name = trimmed
                        try self.viewContext.save()
                    }catch{
                        print("TODO: handle err")
                    }
                    
                }
            }){
                Text("Uložiť")
            }
            
            
        }.padding()
    }
}
