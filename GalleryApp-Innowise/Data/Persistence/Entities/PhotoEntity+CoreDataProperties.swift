//
//  PhotoEntity+CoreDataProperties.swift
//  GalleryApp-Innowise
//
//  Created by Валерий Новиков on 7.10.25.
//
//

import Foundation
import CoreData

extension PhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var width: Int64
    @NSManaged public var height: Int64
    @NSManaged public var averageColor: String
    @NSManaged public var descriptionText: String?
    @NSManaged public var altDescription: String?
    @NSManaged public var thumbnailUrl: String
    @NSManaged public var fullUrl: String
    @NSManaged public var authorName: String
    @NSManaged public var authorUsername: String

}

extension PhotoEntity: Identifiable {

}
