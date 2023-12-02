//
//  EventDetailsViewController.swift
//  EmberLinkIOS
//
//  Created by Lathindu Pahasara on 2023-11-30.
//

import UIKit

class EventDetailsViewController: UIViewController {
    
    
    var item: EventItem?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var EventOrganizerName: UILabel!
    
    
    @IBOutlet weak var EventName: UILabel!
    
    @IBOutlet weak var ParticipantLimit: UILabel!
    
    @IBOutlet weak var EventTime: UILabel!
    
    
    @IBOutlet weak var EventVenue: UILabel!
    
    
    @IBOutlet weak var EventDescription: UILabel!
    
    @IBOutlet weak var EventTag: UILabel!
    
    
    @IBOutlet weak var Participants: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayItemDetails()
    }
    
    
    
    
    @IBAction func EditAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title:"Edit Event",
                                      message: "",preferredStyle: .alert)
        
        alert.addTextField{TextField in TextField.placeholder = self.item?.eventOrganizer}
        alert.addTextField{TextField in TextField.placeholder = self.item?.eventName}
        alert.addTextField{TextField in TextField.placeholder = self.item?.participantsLimit}
        alert.addTextField{TextField in TextField.placeholder = self.item?.eventTime}
        alert.addTextField{TextField in TextField.placeholder = self.item?.eventVenue}
        alert.addTextField{TextField in TextField.placeholder = self.item?.eventDescription}
        alert.addTextField{TextField in TextField.placeholder = self.item?.eventTag}
        
        alert.addAction(UIAlertAction(title: "Save", style: .cancel,handler: { [weak self] _ in
            guard let field1 = alert.textFields?[0],let field2 = alert.textFields?[1],
                  let field3 = alert.textFields?[2], let field4 = alert.textFields?[3],
                  let field5 = alert.textFields?[4],let field6 = alert.textFields?[5],let field7 = alert.textFields?[6],
                  let newOrganizerNametxt = field1.text, let newEventNametxt = field2.text,
                  let newParticipantLimit = field3.text,
                  let newEventTime = field4.text, let newEventVenue = field5.text, let newEventDescription = field6.text, let newEventTag = field7.text  else{
                
                return
            }
            
            if let eventItem = self?.item {
                self?.EditCheck(event: eventItem, newEventOrganizer: newOrganizerNametxt, newEventName: newEventNametxt, newParticipantsLimit: newParticipantLimit, newEventTime: newEventTime, newEventVenue: newEventVenue, newEventDescription: newEventDescription, newEventTag: newEventTag)
            } else {
                print("Error deleting event: possible event nill")

            }
            
            
        }))
            
        
        
        self.present(alert,animated: true)
           
    }
    
    
    
    
    

    @IBAction func DeleteAction(_ sender: UIButton) {
        
        if let eventToDelete = item {
               deleteEvent(event: eventToDelete)
           }
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
    
    @IBAction func JoinAction(_ sender: UIButton) {
        
        
        let participantLimitString = item?.participantsLimit ?? "" // Assuming this is a String
        if let participantLimitInt = Int32(participantLimitString) {
            if(item!.currentParticipantCount  < participantLimitInt){
                
                let alert = UIAlertController(title:"Join Event",
                                              message: "",preferredStyle: .alert)
                
               
                alert.addTextField{TextField in TextField.placeholder = "Enter Your name"}
                
                alert.addAction(UIAlertAction(title: "Save", style: .cancel,handler: { [weak self] _ in
                    guard let field1 = alert.textFields?[0],
                           let newParticipantName = field1.text  else{
                        
                        return
                    }
                    
                    
                    
                    
                    if let eventItem = self?.item {
                        self?.AddParticipant(event: eventItem, name: newParticipantName)
                    } else {
                        print("Error Adding participant to  event")

                    }
                    
                    
                }))
                    
                
                
                self.present(alert,animated: true)
            }
            else{
                let alert = UIAlertController(title:"Event Full!!",
                                              message: "",preferredStyle: .alert)
                self.present(alert,animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    alert.dismiss(animated: true, completion: nil)
                }
                
            }
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    func deleteEvent(event:EventItem){
        context.delete(event)
        do{
            try context.save()
        }
        catch{
            print("Error deleting event: \(error.localizedDescription)")
        }
    }
    
    
    
    func EditCheck(event:EventItem,newEventOrganizer:String,newEventName:String ,newParticipantsLimit:String,newEventTime:String,newEventVenue:String,newEventDescription:String,newEventTag:String){
        
        if !newEventOrganizer.isEmpty {
                event.eventOrganizer = newEventOrganizer
            }

            if !newEventName.isEmpty {
                event.eventName = newEventName
            }

            if !newParticipantsLimit.isEmpty {
                event.participantsLimit = newParticipantsLimit
            }

            if !newEventTime.isEmpty {
                event.eventTime = newEventTime
            }

            if !newEventVenue.isEmpty {
                event.eventVenue = newEventVenue
            }

            if !newEventDescription.isEmpty {
                event.eventDescription = newEventDescription
            }

            if !newEventTag.isEmpty {
                event.eventTag = newEventTag
            }

            // Save the changes to the context if needed
            do {
                try context.save()
                // Handle successful update
            } catch {
                // Handle the error
            }
    }
    
    
    
    func updateItem(event:EventItem,newEventOrganizer:String,newEventName:String ,newParticipantsLimit:String,newEventTime:String,newEventVenue:String,newEventDescription:String,newEventTag:String){
        
        
        event.eventOrganizer = newEventOrganizer
        event.eventName = newEventName
        event.participantsLimit = newParticipantsLimit
        event.eventTime = newEventTime
        event.eventDescription = newEventDescription
        event.eventVenue = newEventVenue
        event.eventTag = newEventTag
        
        do{
            try context.save()
            
        }
        catch{
            
        }
        
    }
    
    func AddParticipant (event:EventItem,name:String){
            if (event.participants == "") {
                event.participants = name
            }
            else{
                
                event.participants = (event.participants ?? "") + ", " + name
            }
            do{
                try context.save()
                
            }
            catch{
                
            }
            
    }
    
    
    
    
    
    func displayItemDetails() {
            // Check if item is not nil and update UI with its attributes
            if let selectedItem = item {
                EventOrganizerName.text = "Organizer: " + (selectedItem.eventOrganizer ?? "")
                EventName.text = "EventName: " + (selectedItem.eventName ??  "")
                ParticipantLimit.text = "Participant Limit: " + (selectedItem.participantsLimit ??  "")
                EventTime.text = "Time: " + (selectedItem.eventTime ??  "")
                EventVenue.text = "Venue: " + (selectedItem.eventVenue ??  "")
                EventDescription.text = "Description: " + (selectedItem.eventDescription ??  "")
                EventTag.text = "Tag: " + (selectedItem.eventTag ??  "")
                Participants.text = "Participants: " + (selectedItem.participants ??  "")
                
            }
        }
    

}
