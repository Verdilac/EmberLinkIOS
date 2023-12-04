//
//  CreateEventViewController.swift
//  EmberLinkIOS
//
//  Created by Loise Study on 2023-12-02.
//

import UIKit

class CreateEventViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var eventTime: UIDatePicker!
    @IBOutlet weak var eventOrganizer: UITextField!
    @IBOutlet weak var participantsLimit: UITextField!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDescription: UITextField!
    @IBOutlet weak var eventTag: UITextField!
    @IBOutlet weak var eventVenueLatitude: UITextField!
    @IBOutlet weak var eventVenueLongitude: UITextField!
    
    // MARK: - Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var eventModel = EventModel();
    var eventListingController = EventListingTableViewController();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitButton(_ sender: UIButton) {
        var didCreateEvent = eventModel.createEvent(
            context: context,
            organizerName: eventOrganizer.text ?? "",
            eventName: eventName.text ?? "",
            participantsLimit: participantsLimit.text ?? "",
            eventTime: eventTime.date,
            eventVenue: eventVenueLatitude.text ?? "",
            eventDescription: eventDescription.text ?? "",
            eventTag: eventTag.text ?? ""
        );
        
        if(didCreateEvent) {
            eventListingController.getAllEvents();
            navigationController?.popViewController(animated: true);
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
