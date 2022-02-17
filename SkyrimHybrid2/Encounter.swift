//
//  Encounter.swift
//  SkyrimHybrid2
//
//  Created by Michael Olgren on 2/17/22.
//

import Foundation
import CoreData

@objc(Encounter)

public class Encounter: NSManagedObject {
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<Encounter> {
        return NSFetchRequest<Encounter>(entityName: "Encounter")
    }
    
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var startAction: String
    @NSManaged public var startLocation: String
    @NSManaged public var hasMapMarker: Bool
    @NSManaged public var descSteps: String
    @NSManaged public var loot: String
    @NSManaged public var isComplete: Bool
}

extension Encounter: Identifiable {}
