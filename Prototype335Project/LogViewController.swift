//
//  LogViewController.swift
//  aGardenLog
//
//  Created by felipe on 4/19/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit
import CoreData

class LogViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    let picker = UIImagePickerController()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var log: LogEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status.textColor = UIColor.green
        status.isHidden = true
        photo.image = UIImage(data: log?.photo as! Data)
        details.text = log?.entry
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        dateLabel.text = formatter.string(from: log?.date as! Date)
        // Do any additional setup after loading the view.
        details.isEditable = false
        details!.layer.borderWidth = 1
        details!.layer.borderColor = UIColor.black.cgColor
        saveButton.isEnabled = false
        addPhotoButton.isHidden = true
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
    @IBAction func edit(_ sender: Any) {
        details.isEditable = true
        addPhotoButton.isHidden = false
        saveButton.isEnabled = true
    }

    @IBAction func save(_ sender: Any) {
       // let ent = NSEntityDescription.entity(forEntityName: "LogEntity", in: self.managedObjectContext)
        
        //let log = LogEntity(entity: ent!, insertInto: managedObjectContext)
        //plant entity needs to be passed in via segue
        log?.entry =  details.text
        let image = photo.image
        let imageData = UIImagePNGRepresentation(image!)
        log?.photo = imageData! as NSData?
        do {
            try managedObjectContext.save()
            
        } catch let error {
            status.text = error.localizedDescription
            status.textColor = UIColor.red
            
        }
        status.isHidden = false
        saveButton.isEnabled = false
        details.isEditable = false
        addPhotoButton.isHidden = true

    }
    //MARK: - image picker
    
    func imagePickerController( _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String:Any]){
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photo.contentMode = .scaleAspectFit
        photo.image = selectedImage
        picker.dismiss(animated: true, completion: nil)
        addPhotoButton.isHidden = true
    }
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func changePhoto(_ sender: Any) {
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
    //MARK: - keyboard
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
        self.details.resignFirstResponder()
        
        
    }

    
}
