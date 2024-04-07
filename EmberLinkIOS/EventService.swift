//
//  EventService.swift
//  EmberLinkIOS
//
//  Created by Loise Study on 2024-04-07.
//

import Foundation
import CoreData

class EventService {
    static func getLatestEvent() -> EventItem? {
        // Create a fetch request for EventItem entity
        let fetchRequest: NSFetchRequest<EventItem> = EventItem.fetchRequest()
        
        // Set the sort descriptor to sort by eventTime in descending order
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "eventTime", ascending: false)]
        
        // Set the fetch limit to 1 to retrieve only the latest event
        fetchRequest.fetchLimit = 1
        
        do {
            // Perform the fetch request
            let events = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            
            // Return the first (latest) event, if available
            return events.first
        } catch {
            // Handle fetch error
            print("Failed to fetch latest event: \(error)")
            return nil
        }
    }
}