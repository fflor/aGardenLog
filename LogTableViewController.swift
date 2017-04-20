//
//  LogTableViewController.swift
//  Prototype335Project
//
//  Created by felipe on 3/20/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit
import CoreData

class LogTableViewController: UITableViewController {
    
    @IBOutlet var logList: UITableView!
    
    //MARK: - core data
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var plant:PlantEntity?
    var logs = [LogEntity]()

    
    
    func fetchRecord() ->Int {
        //create a new fetch request using PlantEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LogEntity")
        fetchRequest.predicate = NSPredicate(format: "plant.plantName == %@", (plant?.plantName)!)
        var count = 0
        // Execute the fetch request and save the results to the array, plants
        logs = (( try? managedObjectContext.fetch(fetchRequest)) as? [LogEntity])!

        
        count = logs.count
        print(logs)
        return count
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        logList.delegate = self
        logList.dataSource = self
        _ = fetchRecord()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        _ = fetchRecord()
        logList.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return logs.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as! LogTableViewCell
        let formatter = DateFormatter()
        formatter.dateStyle = .short

        
        cell.date.text = formatter.string(from: logs[indexPath.row].date as! Date)
        cell.photo.image = UIImage(data: logs[indexPath.row].photo as! Data)
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            managedObjectContext.delete(logs[indexPath.row])
            do{
                
                try managedObjectContext.save()
            }catch let error{
                print("\(error.localizedDescription)")
            }
            
            logs.remove(at: indexPath.row)
            logList.reloadData()
            

        }
    }
    

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        
        if(segue.identifier == "toAddLog"){
            
            if let addlogviewController: AddLogViewController = segue.destination as? AddLogViewController{
                addlogviewController.plant = plant
            }
        }
        
    }

}
