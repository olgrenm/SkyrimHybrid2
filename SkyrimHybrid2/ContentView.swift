//
//  ContentView.swift
//  SkyrimHybrid2
//
//  Created by Michael Olgren on 2/17/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var addViewShown = false
    let viewModel = ListViewModel()
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(
                keyPath: \Encounter.name,
                ascending: true)
        ],
        animation: .default)
    private var encounters: FetchedResults<Encounter>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(encounters) { encounter in
                    NavigationLink {
                        AddEncounterView(encounterId: encounter.objectID)
                    } label: {
                        EncounterView(encounter: encounter)
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteItem(
                        for: indexSet,
                        section: encounters,
                        viewContext: viewContext)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addViewShown = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $addViewShown) {
                AddEncounterView()
            }
            .navigationTitle("Skyrim Encounters")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
