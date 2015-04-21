//
//  WorldGenerator.swift
//  Sparky
//
//  Created by Aditya Chugh on 2015-03-28.
//  Copyright (c) 2015 Spark Education. All rights reserved.
//

import UIKit
import Foundation

class WorldGenerator {
    
    init() {
        
    }
    
    func generateWorld() {
        
    }
    
    var cells = Array<Array<SparkyGridCell>>()
    var candies = 0
    var name = ""
    var sparky = Sparky()
    var cellDimension = 0
    
    func addWall(x:Int, y:Int) {
        self.cells[x-1][y-1].isWall = true
    }
    
    func numberOfColumns() -> Int {
        return 0
    }
    
    func numberOfRows() -> Int {
        return 0
    }
    
    func setCandiesInBag(candies:Int) {
        self.candies = candies
    }
    
    func setLevelName(name:String) {
        self.name = name
    }
    
    func setSparky(x:Int, y:Int) {
        sparky.currentPosition = CGPointMake(CGFloat(x-1), CGFloat(y-1))
        sparky.frame = CGRectMake(CGFloat(cellDimension*(x-1)), CGFloat(cellDimension*(y-1)), CGFloat(cellDimension), CGFloat(cellDimension))
    }
    
    func addCandy(x:Int, y:Int, quantity:Int) {
        self.cells[x-1][y-1].numberOfCandies += quantity
    }
}
