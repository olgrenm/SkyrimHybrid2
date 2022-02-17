//
//  AddEncounterView.swift
//  SkyrimHybrid2
//
//  Created by Michael Olgren on 2/17/22.
//

import SwiftUI
import CoreData

struct AddEncounterView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    @State private var name = ""
    @State private var type = ""
    @State private var startAction = ""
    @State private var startLocation = ""
    @State private var hasMapMarker = false
    @State private var descSteps = ""
    @State private var loot = ""
    @State private var isComplete = false
    @State private var nameError = false
    @State private var types = ["Quest, main", "Quest, side", "Quest, misc", "Ruins", "Cave", "Shrine", "Dragon lair", "House", "Mine", "Standing stone", "Misc", "Random"]
    
    var encounterId: NSManagedObjectID?
    let viewModel = AddEncounterViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        VStack {
                            TextField("Name", text: $name,
                            prompt: Text("Name"))
                                .disableAutocorrection(true)
                            if nameError {
                                Text("Name is required")
                                    .foregroundColor(.red)
                            }
                        }
                        VStack {
                            Picker("Encounter type", selection: $type) {
                                ForEach(types, id: \.self) {
                                    Text($0)
                                }
                            }
                            TextField("Start action", text: $startAction)
                                .disableAutocorrection(true)
                            TextField("Start location", text: $startLocation)
                                .disableAutocorrection(true)
                            Toggle("Map marker?", isOn: $hasMapMarker)
                        }
                    }
                    Section("Description / Steps") {
                        VStack {
                            TextEditor(text: $descSteps)
                                .disableAutocorrection(true)
                        }
                    }
                    Section {
                        VStack {
                            TextField("Loot", text: $loot)
                                .disableAutocorrection(true)
                            Toggle("Completed?", isOn: $isComplete)
                        }
                    }
                    Button {
                        if name.isEmpty {
                            nameError = name.isEmpty
                        } else {
                            let values = EncounterValues(
                                name: name,
                                type: type,
                                startAction: startAction,
                                startLocation: startLocation,
                                hasMapMarker: hasMapMarker,
                                descSteps: descSteps,
                                loot: loot,
                                isComplete: isComplete)
                            
                            viewModel.saveEncounter(
                                encounterId: encounterId,
                                with: values,
                                in: viewContext)
                            presentation.wrappedValue.dismiss()
                        }
                    } label: {
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: 300)
                    }
                    .tint(Color.green)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 5))
                    .controlSize(.large)
                }  // end Form
                .navigationTitle("\(encounterId == nil ? "Add Encounter" : "Edit Encounter")")
                Spacer()
            }
            .onAppear {
                guard
                    let objectId = encounterId,
                    let encounter = viewModel.fetchEncounter(for: objectId, context: viewContext)
                else {
                    return
                }
                
                name = encounter.name
                type = encounter.type
                startAction = encounter.startAction
                startLocation = encounter.startLocation
                hasMapMarker = encounter.hasMapMarker
                descSteps = encounter.descSteps
                loot = encounter.loot
                isComplete = encounter.isComplete
            }
        }
    }
}

struct AddEncounterView_Previews: PreviewProvider {
    static var previews: some View {
        AddEncounterView()
    }
}
