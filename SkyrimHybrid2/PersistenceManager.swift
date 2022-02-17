//
//  PersistenceManager.swift
//  SkyrimHybrid2
//
//  Created by Michael Olgren on 2/17/22.
//

import Foundation
import CoreData

struct PersistenceManager {
    static let shared = PersistenceManager()
    
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "Stash")
        if inMemory,
           let storeDescription = persistentContainer.persistentStoreDescriptions.first {
            storeDescription.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unable to configure Core Data Store: \(error), \(error.userInfo)")
            }
        }
    }
    
    static var preview: PersistenceManager = {
        let result = PersistenceManager(inMemory: true)
        let viewContext = result.persistentContainer.viewContext
        for encounterNumber in 0..<5 {
            let newEncounter = Encounter(context: viewContext)
            newEncounter.name = "Encounter \(encounterNumber)"
            newEncounter.type = "Quest, main"
            newEncounter.startAction = "tt Camilla"
            newEncounter.startLocation = "Whiterun market"
            newEncounter.hasMapMarker = true
            newEncounter.descSteps = "persuade, bribe, or brawl Mikael"
            newEncounter.loot = "250gp"
            newEncounter.isComplete = false
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
}
