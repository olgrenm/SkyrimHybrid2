//
//  ListViewModel.swift
//  SkyrimHybrid2
//
//  Created by Michael Olgren on 2/17/22.
//

import Foundation
import CoreData
import SwiftUI

struct ListViewModel {
    func deleteItem(
        for indexSet: IndexSet,
        section: FetchedResults<Encounter>,
        viewContext: NSManagedObjectContext
    ){
        indexSet.map { section[$0]}.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
