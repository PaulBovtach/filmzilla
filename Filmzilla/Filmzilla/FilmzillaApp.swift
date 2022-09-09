//
//  FilmzillaApp.swift
//  Filmzilla
//
//  Created by Павло on 27.08.2022.
//

import SwiftUI

@main
struct FilmzillaApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
