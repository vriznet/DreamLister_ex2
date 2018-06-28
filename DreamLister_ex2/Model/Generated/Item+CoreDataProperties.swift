//
//  Item+CoreDataProperties.swift
//  DreamLister_ex2
//
//  Created by vriz on 2018. 6. 28..
//  Copyright © 2018년 vriz. All rights reserved.
//
//

import Foundation
import CoreData

extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var price: Double
    @NSManaged public var toStore: Store?
    @NSManaged public var toImage: Image?
    @NSManaged public var toItemType: ItemType?

}
