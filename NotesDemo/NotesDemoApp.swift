//
//  NotesDemoApp.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 11/12/2020.
//

import SwiftUI

@main
struct NotesDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            FolderView(viewModel: FolderView.FolderModel.init(moc: persistenceController.container.viewContext))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
