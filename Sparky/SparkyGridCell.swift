//
//  SparkyGridCell.swift
//  Sparky
//
//  Created by Aditya Chugh on 2015-03-27.
//  Copyright (c) 2015 Spark Education. All rights reserved.
//

import UIKit
import QuartzCore

class SparkyGridCell: UIView {
    
    @IBOutlet private var view: UIView!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var numberLabel: UILabel!
    private var candies = 0
    private var wall = false
    
    var coordinate = CGPoint()
    var errorHandler: ErrorHandler?
    var numberOfCandies: Int {
        get {
            return candies
        }
        set {
            candies = newValue
            imageView.backgroundColor = UIColor.clearColor()
            if newValue > 1 {
                wall = false
                numberLabel.hidden = false
                numberLabel.text = "\(newValue)"
                imageView.image = UIImage(named: "Candy Cell")
            } else if newValue == 0 {
                numberLabel.hidden = true
                imageView.image = UIImage(named: "Empty Cell")
            } else if newValue < 0 {
                if let handler = errorHandler {
                    handler.errorOccured("You tried to pick up candy when there was no candy there!")
                }
            }
            else {
                wall = false
                numberLabel.hidden = true
                imageView.image = UIImage(named: "Candy Cell")
            }
        }
    }
    var isWall: Bool {
        get {
            return wall
        }
        set {
            wall = newValue
            if wall {
                candies = 0
                imageView.image = nil
                imageView.backgroundColor = UIColor.blackColor()
            } else {
                initalState()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("SparkyGridCell", owner: self, options: nil)
        self.bounds = self.view.bounds
        self.addSubview(view)
        initalState()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("SparkyGridCell", owner: self, options: nil)
        self.addSubview(view)
        initalState()
    }
    
    private func delayTime(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func initalState() {
        imageView.image = UIImage(named: "Empty Cell")
        numberLabel.hidden = true
        imageView.backgroundColor = UIColor.clearColor()
    }
}