//
//  Restaurant.swift
//  FoodPin
//
//  Created by newbie on 2020/4/5.
//  Copyright © 2020 newbie. All rights reserved.
//

import Foundation


class Restaurant {
    var name:String
    var type :String
    var location:String
    var image :String
    
    var isVisited:Bool
    
    var phone:String
    
    
    init(name:String,type:String,location:String,image:String,isVisited:Bool,phone:String) {
        self.image = image
        self.type  = type
        self.isVisited = isVisited
        self.name = name
        self.location = location
        self.phone = phone
    }

    convenience init() {
        self.init(name: "",type: "",location: "",image: "",isVisited: false,phone:"")
    }
    
}
