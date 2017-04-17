//
//  LogEntry.swift
//  aGardenLog
//
//  Created by felipe on 4/17/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import Foundation
import UIKit

class LogEntry{
    var name:String = ""
    var log:String = ""
    var pic: UIImage = UIImage(named: "succulent")!
    
    init (n:String, l: String){
        name = n
        log = l
    }
}
