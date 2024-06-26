//
//  ViewController.swift
//  EmberLinkIOS
//
//  Created by Lathindu Pahasara on 2023-11-29.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
//        let modelIndex = indexPath.row / 7 // Index of the current EventItem
//           let attributeIndex = indexPath.row % 7 // Index of the current attribute
//
//           let model = models[modelIndex]
//
//           var attributes: [(name: String, value: String?)] = [
//               ("Event Name", model.eventName),
//               ("eventOrganizer", model.eventOrganizer),
//               ("EventParticipantLimit ", model.participantsLimit),
//               ("EventTime", model.eventTime),
//               ("EventVenue", model.eventVenue),
//               ("EventDescription", model.eventDescription),
//               ("EventTag", model.eventTag)
//           ]
//
//           let attribute = attributes[attributeIndex]
//
//           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//           cell.textLabel?.text = "\(attribute.name): \(attribute.value ?? "")"
//
//           return cell
        
//        let modelIndex = indexPath.row / 7 // Index of the current EventItem
//            let attributeIndex = indexPath.row % 7 // Index of the current attribute
//
//            let model = models[modelIndex]
//
//            var attributeText: String = ""
//
//            switch attributeIndex {
//            case 0:
//                attributeText = model.eventName ?? ""
//            case 1:
//                attributeText = model.eventOrganizer ?? ""
//            case 2:
//                attributeText = model.eventTime ?? ""
//            case 3:
//                attributeText = model.participantsLimit ?? ""
//            case 4:
//                attributeText = model.eventVenue ?? ""
//            case 5:
//                attributeText = model.eventDescription ?? ""
//            case 6:
//                attributeText = model.eventTag ?? ""
//            default:
//                break
//            }
//
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//            cell.textLabel?.text = "Attribute \(attributeIndex + 1): \(attributeText)"
//
//            return cell
      
        
        
        
        
        
        
        
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if let eventName = model.eventName, let eventTag = model.eventTag, let eventOrganizer = model.eventOrganizer {
            cell.textLabel?.text = "\(eventName) - #\(eventTag) by \(eventOrganizer)"
        } else {
            // Handle the case where either eventName or eventTag is nil
            cell.textLabel?.text = "Unavailable"
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let selectedItem = models[indexPath.row] // Retrieve the selected item based on the index path
          
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          
          if let detailsViewController = storyboard.instantiateViewController(withIdentifier: "event_details_vc") as? EventDetailsViewController {
              detailsViewController.item = selectedItem // Pass the selected item to EventDetailsViewController
              navigationController?.pushViewController(detailsViewController, animated: true)
          }
      }
    
    
   
      
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier:"cell")
        return table
    }()
    
    
    private var models = [EventItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "EventList"
        view.addSubview(tableView)
        getAllEvents()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(didTapAdd))
    }
    
    // Trigger a notification for the last event
    func scheduleRepeatingNotifications() {
        // Remove the existing notification requests
        removePreviousNotifications()
        
        guard let lastEvent = models.last else {
            return
        }
        
        // Generate and schedule notification for the latest event
        NotificationGenerator.generateRepeatingNotification(
            title: "Upcoming event",
            description: "Hey, this is a reminder for \(lastEvent.eventName ?? "") on \(lastEvent.eventTime ?? "")"
        )
    }

    // Remove previous notification requests
    func removePreviousNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            getAllEvents()
        }
    
    func getAllEvents(){
        
        do {
            models = try context.fetch(EventItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            scheduleRepeatingNotifications()
        }
        catch {
            //Error
        }
        
        
    }
    
    
    func createEvent(orgnizerName:String ,eventName:String ,participantsLimit:String,eventTime:String,eventVenue:String,eventDescription:String,eventTag:String ){
        
        let newEvent = EventItem(context: context)
        newEvent.eventOrganizer = orgnizerName
        newEvent.eventName = eventName
        newEvent.participantsLimit = participantsLimit
        newEvent.eventTime = eventTime
        newEvent.eventVenue = eventVenue
        newEvent.eventDescription = eventDescription
        newEvent.eventTag = eventTag
        newEvent.participants = orgnizerName
        newEvent.currentParticipantCount = 0
        
        
        do{
            try context.save()
            getAllEvents()
        }
        catch{
            
        }
        
    }
    
    @objc private func didTapAdd()
    {
        let alert = UIAlertController(title:"New Event",
                                      message: "Enter New Event",preferredStyle: .alert)
        
        
        alert.addTextField { textField in
            textField.placeholder = "organizer Name"
            
            alert.addTextField { textField in
                textField.placeholder = "eventName"
            }
            alert.addTextField { textField in
                textField.placeholder = "participantLimit"
            }
            alert.addTextField { textField in
                textField.placeholder = "eventTime"
            }
            alert.addTextField { textField in
                textField.placeholder = "eventVenue"
            }
            alert.addTextField { textField in
                textField.placeholder = "EventDescription"
            }
            alert.addTextField { textField in
                textField.placeholder = "EventTag"
            }
            
            alert.addAction(UIAlertAction(title: "Submit", style: .cancel,handler: { [weak self] _ in
                guard let field1 = alert.textFields?[0],let field2 = alert.textFields?[1],
                      let field3 = alert.textFields?[2], let field4 = alert.textFields?[3],
                      let field5 = alert.textFields?[4],let field6 = alert.textFields?[5],let field7 = alert.textFields?[6],
                      let organizerNametxt = field1.text, let eventNametxt = field2.text,
                      let participantLimit = field3.text,
                      let eventTime = field4.text, let eventVenue = field5.text, let EventDescription = field6.text, let EventTag = field7.text , !eventNametxt.isEmpty else{
                    return
                    
                }
                
                
                self?.createEvent(orgnizerName: organizerNametxt, eventName: eventNametxt, participantsLimit: participantLimit, eventTime: eventTime, eventVenue: eventVenue, eventDescription: EventDescription, eventTag: EventTag)
                
            }))
            
            self.present(alert,animated: true)
        }
    
        
        //CoreData Logic
        
        func deleteEvent(event:EventItem){
            context.delete(event)
            do{
                try context.save()
            }
            catch{
                
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
    }
}
