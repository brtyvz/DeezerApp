//
//  DeezerAppApp.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 9.05.2023.
//

import SwiftUI

@main
struct DeezerAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GenreView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
