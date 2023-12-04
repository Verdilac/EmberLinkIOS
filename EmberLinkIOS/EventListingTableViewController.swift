//
//  EventListingTableViewController.swift
//  EmberLinkIOS
//
//  Created by Loise Study on 2023-12-02.
//

import UIKit
import CoreData

class EventListingTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllEvents()
        //tableView.delegate = self
        //tableView.dataSource = self
        //tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getAllEvents()
    }
    
    // MARK: - Table view data source
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var eventModel = EventModel();
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventModel.models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "event_listing_tablecell", for: indexPath) as! EventListingTableViewCell
        let model = eventModel.models[indexPath.row]
        
        cell.eventNameLabel.text = model.eventName;
        cell.eventOrganizerLabel.text = model.eventOrganizer;
        
        return cell
    }
    
    
    public func getAllEvents() {
        let success = eventModel.getAllEvents(context: context);
        
        if(success) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


/*
 
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
 
 }
 catch {
 //Error
 }
 
 
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
 */
