//
//  SkyrimHybrid2App.swift
//  SkyrimHybrid2
//
//  Created by Michael Olgren on 2/17/22.
//

import SwiftUI

@main
struct SkyrimHybrid2App: App {
    let persistenceManager = PersistenceManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceManager.persistentContainer.viewContext)
        }
    }
}
