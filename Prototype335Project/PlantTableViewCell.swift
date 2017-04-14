//
//  PlantTableViewCell.swift
//  Prototype335Project
//
//  Created by felipe on 3/20/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!

    @IBOutlet weak var plantName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
