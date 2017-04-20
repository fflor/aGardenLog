//
//  AddViewController.swift
//  aGardenLog
//
//  Created by felipe on 4/17/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var plantName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var saveButton: UIToolbar!

       let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status.textColor = UIColor.green
        status.isHidden = true
        saveButton.isHidden = false
        // Do any additional setup after loading the view.
        details!.layer.borderWidth = 1
        details!.layer.borderColor = UIColor.black.cgColor
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
        
        
        let ent = NSEntityDescription.entity(forEntityName: "PlantEntity", in: self.managedObjectContext)
        
        let plant = PlantEntity(entity: ent!, insertInto: managedObjectContext)
        plant.plantName = plantName.text
        plant.date = datePicker.date as NSDate?
        plant.details = details.text
        
        let imageData = UIImagePNGRepresentation(photo.image!)
        plant.picture = imageData! as NSData?
        do {
            try managedObjectContext.save()
                       
            
        } catch let error {
            status.text = error.localizedDescription
            status.textColor = UIColor.red
        }
        status.isHidden = false
        saveButton.isHidden = true
        
    }

    
    //TODO: -add image picker
}
