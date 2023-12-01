//
//  EventDetailsViewController.swift
//  EmberLinkIOS
//
//  Created by Lathindu Pahasara on 2023-11-30.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    
    var item: EventItem?

    @IBOutlet weak var EventOrganizerName: UILabel!
    
    
    @IBOutlet weak var EventName: UILabel!
    
    @IBOutlet weak var ParticipantLimit: UILabel!
    
    @IBOutlet weak var EventTime: UILabel!
    
    
    @IBOutlet weak var EventVenue: UILabel!
    
    
    @IBOutlet weak var EventDescription: UILabel!
    
    @IBOutlet weak var EventTag: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayItemDetails()
    }
    

    
    func displayItemDetails() {
            // Check if item is not nil and update UI with its attributes
            if let selectedItem = item {
                EventOrganizerName.text = selectedItem.eventOrganizer
                EventName.text = selectedItem.eventName
                ParticipantLimit.text = selectedItem.participantsLimit
                EventTime.text = selectedItem.eventTime
                EventVenue.text = selectedItem.eventVenue
                EventDescription.text = selectedItem.eventDescription
                EventTag.text = selectedItem.eventTag
                
            }
        }
    

}
