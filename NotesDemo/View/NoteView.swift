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
        List{
            ForEach(self.folder.wContains){ note in
                Text(note.name ?? "Unknown")
            }
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(folder: Folder())
    }
}
