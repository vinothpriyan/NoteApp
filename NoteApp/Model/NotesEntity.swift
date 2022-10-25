//
//  NotesEntity+CoreDataProperties.swift
//
//
//  Created by Vinoth Priyan on 15/09/22.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData
import UIKit

@objc(NotesEntity)
class NotesEntity: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotesEntity> {
        return NSFetchRequest<NotesEntity>(entityName: "NotesEntity")
    }

    @NSManaged public var archived: Bool
    @NSManaged public var body: String?
    @NSManaged public var created_time: Date?
    @NSManaged public var expiry_time: Date?
    @NSManaged public var image: UIImage?
    @NSManaged public var title: String?
    @NSManaged public var uid: String?

}

extension NotesEntity : Identifiable {

}
