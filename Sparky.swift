
//  Sparky.swift
//  Sparky
//
//  Created by Aditya Chugh on 2015-03-28.
//  Copyright (c) 2015 Spark Education. All rights reserved.
//

import Foundation
import UIKit

class Sparky : SparkyCell {
    
    /*
    
    Functions
    ---------
    move() - Moves Sparky in the direction he is facing
    turnClockwise() - Turns Sparky clockwise
    turnCounterClockwise() - Turns sparky counter-clockwise
    pickUpCandy() - Picks up 1 candy
    putDownCandy() - Puts down 1 candy
    
    
    Checks
    ------
    isFacingNorth() - Returns true if Sparky is facing North
    isFacingSouth() - Returns true if Sparky is facing South
    isFacingEast() - Returns true if Sparky is facing East
    isFacingWest() - Returns true if Sparky is facing West
    frontIsClear() - Returns true if the direction Sparky is facing is clear
    isOnCandy() - Returns true if Sparky is standing on a space with candy on it
    anyCandiesInBag() - Returns true if Sparky has any candies in his bag
    
    */
    
    override func run() {
        for var i = 0; i < 4; ++i {
            while frontIsClear() {
                move()
            }
            turnClockwise()
        }
    }
}