//
//  NoteAppApp.swift
//  NoteApp
//
//  Created by Prasanna Ramesh on 10/09/22.
//

import SwiftUI

@main
struct NoteAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
