//
//  AddViewController.swift
//  aGardenLog
//
//  Created by felipe on 4/17/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var plantName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var saveButton: UIToolbar!
    let picker = UIImagePickerController()

       let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status.textColor = UIColor.green
        status.isHidden = true
        saveButton.isHidden = false
        // Do any additional setup after loading the view.
        details!.layer.borderWidth = 1
        details!.layer.borderColor = UIColor.black.cgColor
        addPhotoButton.isHidden = false//add photo button
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
        let image = picture.image
        let imageData = UIImagePNGRepresentation(image!)
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

    
    //MARK: - image picker
    
    func imagePickerController( _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:Any]){
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        picture.contentMode = .scaleAspectFit
        picture.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
        addPhotoButton.isHidden = true
    }
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func addPhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion:nil)
        }else{
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker,animated:true,completion:nil)
        }
    }
    
    //MARK: - keyboard hiding
    // move the view upwards as keyboard appears
    func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y -= 150
    }
    
    // move the keyboard back as keyboard disapears
    
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y += 150
    }
    
    // make the keyboard disapear as user touches outside the  text boxes
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        self.plantName.resignFirstResponder()
        self.details.resignFirstResponder()
        
    }
}
