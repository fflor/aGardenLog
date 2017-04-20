//
//  PlantData.swift
//  Prototype335Project
//
//  Created by felipe on 3/20/17.
//  Copyright © 2017 felipe. All rights reserved.
//

import Foundation

import UIKit
class plantData
{
    var plants: [record] = []
    
    
    init()
    {
        var newPlant = record(n:"Succulent", d: "This is a test entry")
        newPlant.addPic(UIImage(named:"succulent")!)
        plants.append(newPlant)
       
        newPlant = record(n:"Succulent2", d: "This is a test entry")
        newPlant.addPic(UIImage(named:"succulent")!)
        plants.append(newPlant)
        
        newPlant = record(n:"Succulent3", d: "This is a test entry")
        newPlant.addPic(UIImage(named:"succulent")!)
        plants.append(newPlant)
    }
    
    func deleteEntry (at index:Int){
        plants.remove(at: index)
    }
    
    //func addEntry
    func addEntry (_ rec:record){
        plants.append(rec)
    }
}


class record
{
    var name: String = ""
    var description:String = ""
    var pic: UIImage = UIImage(named: "succulent")!
    var logs:[LogEntry] = []
    
    init (n: String, d: String)
    {
        name=n
        description = d
        
        
    }
    
    internal func getName() -> String
    {
        return name
    }
    internal func getDesc() -> String
    {
        return description
    }
    internal func getImage() -> UIImage
    {
        return pic
    }
    
    internal func addPic(_ picture: UIImage)
    {
        pic = picture
        
    }
    
    
}
