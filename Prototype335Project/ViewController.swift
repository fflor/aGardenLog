//
//  ViewController.swift
//  Prototype335Project
//
//  Created by felipe on 3/20/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var PlantList: UITableView!
    var plantEntries:plantData = plantData()
    
    override func viewDidLoad() {
        PlantList.delegate = self
        PlantList.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View controls
    
    //set the number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantEntries.plants.count
    }
    //fill cells
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! PlantTableViewCell
        
        cell.plantName.text = plantEntries.plants[indexPath.row].getName()
        cell.thumbnail.image = plantEntries.plants[indexPath.row].getImage()
        
        return cell
    }
    
    //Delete cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            plantEntries.deleteEntry(at: indexPath.row)
            PlantList.reloadData()
            
        }
    }
    /*
     class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
     
     @IBOutlet weak var placeTable: UITableView!
     var cities: placeData = placeData()
     var name: String = ""
     
     override func viewDidLoad() {
     super.viewDidLoad()
     // Do any additional setup after loading the view, typically from a nib.
     }
     
     override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Dispose of any resources that can be recreated.
     }
     
     //MARK: - Table View controls
     
     //set the number of rows
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return cities.places.count
     }
     //fill cells
     func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceTableViewCell
     
     cell.cityName.text = cities.places[indexPath.row].getName()
     cell.descSentence.text = cities.places[indexPath.row].getDesc()
     cell.thumbnail.image = cities.places[indexPath.row].getImage()
     
     return cell
     }
     
     //Delete cells
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete{
     cities.deleteEntry(at: indexPath.row)
     placeTable.reloadData()
     
     }
     }
     */
    
    
    @IBAction func unwindToMain(_ segue: UIStoryboardSegue){

    }

}

