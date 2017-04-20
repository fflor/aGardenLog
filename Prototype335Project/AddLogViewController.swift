//
//  AddLogViewController.swift
//  aGardenLog
//
//  Created by felipe on 4/19/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit
import CoreData

class AddLogViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var details: UITextView!
    
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var plant:PlantEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status.isHidden = true;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func save(_ sender: Any) {
        
        
        let ent = NSEntityDescription.entity(forEntityName: "LogEntity", in: self.managedObjectContext)
        
        let log = LogEntity(entity: ent!, insertInto: managedObjectContext)
        //plant entity needs to be passed in via segue
        log.plant = plant
        log.entry =  details.text
        log.date = datePicker.date as NSDate?
        
        
        let imageData = UIImagePNGRepresentation(photo.image!)
        log.photo = imageData! as NSData?
        do {
            try managedObjectContext.save()
            
            
            
        } catch let error {
            status.text = error.localizedDescription
            status.textColor = UIColor.red
        }
        status.isHidden = false
        print(log)
    }
}
