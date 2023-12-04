//
//  EventItem+CoreDataProperties.swift
//  EmberLinkIOS
//
//  Created by Lathindu Pahasara on 2023-11-30.
//
//

import Foundation
import CoreData


extension EventItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventItem> {
        return NSFetchRequest<EventItem>(entityName: "EventItem")
    }

    @NSManaged public var eventOrganizer: String?
    @NSManaged public var eventName: String?
    @NSManaged public var participantsLimit: String?
    @NSManaged public var eventTime: Date?
    @NSManaged public var eventVenueLongitude: String?
    @NSManaged public var eventVenueLatitude: String?
    @NSManaged public var eventDescription: String?
    @NSManaged public var eventTag: String?
    @NSManaged public var participants: String?
    @NSManaged public var currentParticipantCount: Int32
    

}

extension EventItem : Identifiable {

}
