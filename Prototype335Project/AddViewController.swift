//
//  AddViewController.swift
//  aGardenLog
//
//  Created by felipe on 4/17/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var plantName: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var details: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        //TODO: -Save data
    }
    
    //TODO: -add image picker
}
