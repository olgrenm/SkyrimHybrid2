//
//  EncounterView.swift
//  SkyrimHybrid2
//
//  Created by Michael Olgren on 2/17/22.
//

import SwiftUI

struct EncounterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var encounter: Encounter
    
    var body: some View {
        HStack {
            Image(systemName: encounter.isComplete ? "checkmark.square" : "square")
            Text("\(encounter.name)")
            Spacer()
        }
        .padding()
    }
}

struct EncounterView_Previews: PreviewProvider {
    static var previews: some View {
        EncounterView(encounter: getEncounter())
    }
    
    static func getEncounter() -> Encounter {
        let encounter = Encounter(context: PersistenceManager(inMemory: true).persistentContainer.viewContext)
        encounter.name = "Find the gold!"
        encounter.isComplete = true
        return encounter
    }
}
