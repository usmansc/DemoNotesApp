//
//  AlertView.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 12/12/2020.
//

import SwiftUI

struct AlertView: View {
    var title = ""
    var message = ""
    @State var isPresented = true
    var body: some View {
        VStack{

        }.alert(isPresented: $isPresented, content: {
            Alert(title: Text(title), message: Text(message), dismissButton: .default(Text("Ok")))
        })
    }
}
