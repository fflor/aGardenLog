//
//  ViewController.swift
//  Prototype335Project
//
//  Created by felipe on 3/20/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var PlantList: UITableView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var degFLabel: UILabel!
    //@IBOutlet weak var degCLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    var latitude = "82.0"
    var longitude = "33.45"
    var manager:CLLocationManager!
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        PlantList.delegate = self
        PlantList.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _ = fetchRecord()
        dayLabel.text = getWeekday()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

        
        DispatchQueue.main.async(execute: {
         self.getWeather()
         
         })
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        _ = fetchRecord()
        PlantList.reloadData()
    }
    
    //MARK: - Location Services
    
    func locationManager( _ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let userLocation:CLLocation = locations[0]
        latitude = "\(userLocation.coordinate.latitude)"
        longitude = "\(userLocation.coordinate.longitude)"
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
    //MARK: - seques
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
        
        if(segue.identifier == "toLogTable"){
            let selectedPlant: PlantEntity = self.plants[self.PlantList.indexPath(for: sender as! UITableViewCell)!.row]
            
            if let logtableviewController: LogTableViewController = segue.destination as? LogTableViewController{
                logtableviewController.plant = selectedPlant
            }
        }
        
    }
    
    //MARK: - weather and JSON
    
    func getWeekday() -> String {
        //set weekday
        var wkday = "today"
        let today = Calendar.current.component(.weekday, from: Date())
        switch today{
        case 1:
            wkday = "Sunday"
        case 2:
            wkday = "Monday"
        case 3:
            wkday = "Tuesday"
        case 4:
            wkday = "Wednesday"
        case 5:
            wkday = "Thursday"
        case 6:
            wkday = "Friday"
        default:
            wkday = "Saturday"
        }
        return wkday
        
    }
    
    func getWeather() {
        
        
        let dblLat = Double(latitude)!
        let dblLon = Double(longitude)!
        
        
        let urlAsString = "http://api.openweathermap.org/data/2.5/weather?lat=\(dblLat)&lon=\(dblLon)&units=imperial&appid=a5d584d00cb4b3f6734b93649de1e768"
        
       
        let url = URL(string: urlAsString)!
       
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            
            let jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! [String: AnyObject]
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
           // print(jsonResult)
            let report = jsonResult
            let weather = report["weather"]! as? NSArray
            let weatherDict = weather?[0] as? [String: AnyObject]
            let desc = weatherDict?["description"]
            let icon = weatherDict?["icon"] as? String
            let weatherImgName = (icon)! + ".png"
            
            let main = report["main"] as? [String: AnyObject]
            let tempF = (main?["temp"] as? NSNumber)!.doubleValue
            //print(desc!)
            self.descLabel.text = desc as! String?
            self.degFLabel.text = String(format: "%.0f", tempF ) + "\u{00B0}F"
            self.weatherImage.image = UIImage(named: weatherImgName)
            
        })
        
        jsonQuery.resume()
        
        
    }
    
    
    
}

