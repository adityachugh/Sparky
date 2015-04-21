//
//  World.swift
//  Sparky
//
//  Created by Aditya Chugh on 2015-03-28.
//  Copyright (c) 2015 Spark Education. All rights reserved.
//

import Foundation
import UIKit

class World : WorldGenerator {
    
    /*
    
    Functions
    --------
    setSparky(x:Int, y:Int)
    setLevelName(name:String)
    setCandiesInBag(candies:Int)
    addWall(x:Int, y:Int)
    addCandy(x:Int, y:Int, quantity:Int)
    
    */
    
    //Update candies counter
    
    override func numberOfColumns() -> Int {
        return 10
    }
    
    override func numberOfRows() -> Int {
        return 10
    }
    
    override func generateWorld() {
        setLevelName("Swag")
    }
}