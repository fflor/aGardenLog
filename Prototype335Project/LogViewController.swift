//
//  LogViewController.swift
//  aGardenLog
//
//  Created by felipe on 4/19/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    var log: LogEntity?
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = UIImage(data: log?.photo as! Data)
        details.text = log?.entry
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        dateLabel.text = formatter.string(from: log?.date as! Date)
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

}
