//
//  FolderView.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 11/12/2020.
//

import SwiftUI

struct FolderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: FolderModel
    @State private var alert = false
    
    var body: some View {
        NavigationView{
            ZStack {
                List{
                    ForEach(viewModel.folders){ folder in
                        NavigationLink(destination: NoteView(folder:folder,viewModel:NoteView.NoteModel.init(moc: self.viewContext, folder: folder))){
                            VStack(alignment:.leading){
                                Text(folder.name ?? "Unknown")
                                Text(formatDate(folder.date))
                            }
                        }
                    }.onDelete(perform: self.viewModel.removeFolder)
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
                        NewFolderAlert(viewModel: self.viewModel,shown: self.$alert)
                            .frame(width: 300, height: 200, alignment: .center).background(Color.black).cornerRadius(30)
                        Spacer()
                    }.padding()
                    
                }
                
            }
        }
    }
    
    private func formatDate(_ date: Date?) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        if let date = date{
            return formatter.string(from: date)
        }
        return "Unknown"
        
    }
}

struct NewFolderAlert: View{
    @ObservedObject var viewModel: FolderView.FolderModel
    @State private var text = ""
    @Binding<Bool> var shown: Bool
    var body: some View{
        VStack{
            Text("Nový priečinok").foregroundColor(.white)
            Text("Zadajte názov pre tento priečinok").foregroundColor(.white)
            TextField("Názov", text: $text).padding().foregroundColor(.white).overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray))
            Button(action: {
                self.shown.toggle()
                self.viewModel.addNewFolder(name: self.text.trimmingCharacters(in: .whitespacesAndNewlines))
            }){
                Text("Uložiť")
            }
            
            
        }.padding()
    }
}
