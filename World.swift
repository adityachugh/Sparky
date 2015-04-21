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
    
    
    /*To Do
    
    - Update candies counter
    - Update slider
    - Fix isOnCandy()
    
    */
    
    override func numberOfColumns() -> Int {
        return 10
    }
    
    override func numberOfRows() -> Int {
        return 10
    }
    
    override func generateWorld() {
        setLevelName("Welcome to Sparky!")
    }
}