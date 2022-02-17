//
//  AddEncounterViewModel.swift
//  SkyrimHybrid2
//
//  Created by Michael Olgren on 2/17/22.
//

import Foundation
import CoreData

struct AddEncounterViewModel {
    func fetchEncounter(for objectId: NSManagedObjectID, context: NSManagedObjectContext) -> Encounter? {
        guard let encounter = context.object(with: objectId) as? Encounter else {
            return nil
        }
        
        return encounter
    }
    
    func saveEncounter(encounterId: NSManagedObjectID?, with encounterValues: EncounterValues, in context: NSManagedObjectContext) {
        let encounter: Encounter
        if let objectId = encounterId,
           let fetchedEncounter = fetchEncounter(for: objectId, context: context) {
            encounter = fetchedEncounter
        } else {
            encounter = Encounter(context: context)
        }
        
        encounter.name = encounterValues.name
        encounter.type = encounterValues.type
        encounter.startAction = encounterValues.startAction
        encounter.startLocation = encounterValues.startLocation
        encounter.hasMapMarker = encounterValues.hasMapMarker
        encounter.descSteps = encounterValues.descSteps
        encounter.loot = encounterValues.loot
        encounter.isComplete = encounterValues.isComplete
        
        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
}
