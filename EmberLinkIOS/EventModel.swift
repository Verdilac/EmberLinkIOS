//
//  EventModel.swift
//  EmberLinkIOS
//
//  Created by Loise Study on 2023-12-03.
//

import Foundation
import UIKit
import CoreData

class EventModel {
    public var models = [EventItem]()
    
    
    public func createEvent(
        context: NSManagedObjectContext,
        organizerName:String,
        eventName:String,
        participantsLimit:String,
        eventTime:Date,
        eventVenueLongitude:String,
        eventVenueLatitude:String,
        eventDescription:String,
        eventTag:String) -> Bool {
            
            let newEvent = EventItem(context: context)
            newEvent.eventOrganizer = organizerName
            newEvent.eventName = eventName
            newEvent.participantsLimit = participantsLimit
            newEvent.eventTime = eventTime
            newEvent.eventVenueLongitude = eventVenueLongitude
            newEvent.eventVenueLatitude = eventVenueLatitude
            newEvent.eventDescription = eventDescription
            newEvent.eventTag = eventTag
            newEvent.participants = organizerName
            newEvent.currentParticipantCount = 0
            
            
            do{
                try context.save()
                return true
            }
            catch{
                return false
            }
            
        }
    
    public func getAllEvents(
        context: NSManagedObjectContext
    ) -> Bool {
        do {
            models = try context.fetch(EventItem.fetchRequest())
            return true
        }
        catch {
            return false
        }
    }
}
