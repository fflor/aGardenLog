//
//  ViewController.swift
//  Prototype335Project
//
//  Created by felipe on 3/20/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var PlantList: UITableView!
    //var plantEntries:plantData = plantData() commented out to switch to core data
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        PlantList.delegate = self
        PlantList.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _ = fetchRecord()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        _ = fetchRecord()
        PlantList.reloadData()
    }
    
    //MARK: - core data
   let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var plants = [PlantEntity]()
    
    func fetchRecord() ->Int {
        //create a new fetch request using PlantEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlantEntity")
        var count = 0
        // Execute the fetch request and save the results to the array, plants
            plants = (( try? managedObjectContext.fetch(fetchRequest)) as? [PlantEntity])!

            count = plants.count
      
        return count
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Table View controls
    
    //set the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plants.count
    }
    
    //fill cells
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! PlantTableViewCell
        
        cell.plantName.text = plants[indexPath.row].plantName
        cell.thumbnail.image = UIImage(data: plants[indexPath.row].picture as! Data)
        
        return cell
    }
    
    //Delete cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            managedObjectContext.delete(plants[indexPath.row])
            do{
                
                try managedObjectContext.save()
            }catch let error{
                print("\(error.localizedDescription)")
            }
            
            plants.remove(at: indexPath.row)
            PlantList.reloadData()
            
        }
    }
    //TODO: -seque when table cell selected
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //

        if(segue.identifier == "toLogTable"){
            let selectedPlant: PlantEntity = self.plants[self.PlantList.indexPath(for: sender as! UITableViewCell)!.row]
            
            if let logtableviewController: LogTableViewController = segue.destination as? LogTableViewController{
                logtableviewController.plant = selectedPlant
            }
        }
        
    }


}

