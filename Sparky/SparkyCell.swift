//
//  SparkyImplementation.swift
//  Sparky
//
//  Created by Aditya Chugh on 2015-03-28.
//  Copyright (c) 2015 Spark Education. All rights reserved.
//

import UIKit
import Darwin

class SparkyCell: UIView {
    
    var dimension = 75
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    private let animationTime = 0.1
    private var delay = 0.05
    var currentPosition = CGPointMake(0, 0)
    private var currentCell = SparkyGridCell()
    private var candies = 10
    var direction = Direction.East
    private var currentDelay = 0.0
    var errorHandler: ErrorHandler?
    var animationState = AnimationState.HasNotStarted
    var cells = Array<Array<SparkyGridCell>>()
    
    func run() {
        
    }
    
    func startAnimation() {
        animationState = AnimationState.Running
        run()
    }
    
    func changeX(x:Int) {
        currentPosition = CGPointMake((currentPosition.x)+CGFloat(x), CGFloat(currentPosition.y))
    }
    func changeY(y:Int) {
        currentPosition = CGPointMake(CGFloat(currentPosition.x), (currentPosition.y)+CGFloat(y))
    }
    
    //Commands
    
    func move() {
        if !frontIsClear() {
            if let handler = errorHandler {
                handler.errorOccured("You tried to either move outside the grid or intro a wall!")
            }
        } else {
            var code = {
                self.move()
            }
            switch direction {
            case .North:
                code = {
                    self.moveNorth()
                };
            case .South:
                code = {
                    self.moveSouth()
                };
            case .East:
                code = {
                    self.moveEast()
                };
            case .West:
                code = {
                    self.moveWest()
                };
            default:
                self.frame = self.frame
            }
            animateAction(code)
        }
    }
    
    func turnClockwise() {
        animateAction {
            () -> () in
            switch self.direction {
            case .North:
                self.transform = CGAffineTransformMakeRotation(CGFloat(0))
                self.direction = .East
            case .South:
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2*2))
                self.direction = .West
            case .East:
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                self.direction = .South
            case .West:
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2*3))
                self.direction = .North
            default:
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                self.direction = .East
            }
        }
    }
    
    func turnCounterClockwise() {
        animateAction {
            () -> () in
            switch self.direction {
            case .North:
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2*2))
                self.direction = .West
            case .South:
                self.transform = CGAffineTransformMakeRotation(CGFloat(0))
                self.direction = .East
            case .East:
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2*3))
                self.direction = .North
            case .West:
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                self.direction = .South
            default:
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                self.direction = .East
            }
        }
    }
    
    func putDownCandy() {
        
        if candies > 0 {
            --candies
        } else {
            if let handler = errorHandler {
                handler.errorOccured("You tried to place a candy when you had none in your bag!")
            }
        }
        animateAction {
            () -> () in
            let i = Int(self.currentPosition.x)
            let j = Int(self.currentPosition.y)
            self.delayTime(self.currentDelay, closure: {
                () -> () in
                self.frame = self.frame
                ++self.cells[i][j].numberOfCandies
            })
            self.currentDelay += self.delay + self.animationTime
            
        }
    }
    
    func pickUpCandy() {
        ++candies
        animateAction {
            () -> () in
            let i = Int(self.currentPosition.x)
            let j = Int(self.currentPosition.y)
            self.delayTime(self.currentDelay, closure: {
                () -> () in
                self.frame = self.frame
                --self.cells[i][j].numberOfCandies
            })
            self.currentDelay += self.delay + self.animationTime
        }
    }
    
    //Checks
    
    func isFacingNorth() -> Bool {
        return direction == Direction.North
    }
    
    func isFacingSouth() -> Bool {
        return direction == Direction.South
    }
    
    func isFacingEast() -> Bool {
        return direction == Direction.East
    }
    
    func isFacingWest() -> Bool {
        return direction == Direction.West
    }
    
    func frontIsClear() -> Bool {
        switch direction {
        case .North:
            return isCellClear(Int(currentPosition.x), y: Int(currentPosition.y-1))
        case .South:
            return isCellClear(Int(currentPosition.x), y: Int(currentPosition.y+1))
        case .East:
            return isCellClear(Int(currentPosition.x+1), y: Int(currentPosition.y))
        case .West:
            return isCellClear(Int(currentPosition.x-1), y: Int(currentPosition.y))
        default:
            self.frame = self.frame
        }
    }
    
    func isOnCandy() -> Bool {
        return cells[Int(currentPosition.x)][Int(currentPosition.y)].numberOfCandies > 0
    }
    
    func anyCandiesInBag() -> Bool {
        return candies > 0
    }
    
    func isCellThere(x:Int, y:Int) -> Bool {
        if x < 0 || x >= cells.count || y < 0 || y >= cells[0].count {
            return false
        }
        return true
    }
    
    func isCellClear(x:Int, y:Int) -> Bool {
        if isCellThere(x, y: y) {
            if !cells[x][y].isWall {
                return true
            }
        }
        return false
    }
    
    //Move methods
    
    private func moveNorth() {
        changeY(-1)
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y-CGFloat(dimension), CGFloat(dimension), CGFloat(dimension))
    }
    
    private func moveSouth() {
        changeY(+1)
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y+CGFloat(dimension), CGFloat(dimension), CGFloat(dimension))
    }
    
    private func moveEast() {
        changeX(+1)
        self.frame = CGRectMake(self.frame.origin.x+CGFloat(dimension), self.frame.origin.y, CGFloat(dimension), CGFloat(dimension))
    }
    
    private func moveWest() {
        changeX(-1)
        self.frame = CGRectMake(self.frame.origin.x-CGFloat(dimension), self.frame.origin.y, CGFloat(dimension), CGFloat(dimension))
    }
    
    //Init Methods
    
//    init() {
//        super.init()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("SparkyCell", owner: self, options: nil)
        self.bounds = self.view.bounds
        self.addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("SparkyCell", owner: self, options: nil)
        self.addSubview(view)
    }
    
    //Misc Methods
    
    private func animateAction(closure: ()->()) {
        UIView.animateWithDuration(animationTime, delay: currentDelay, options: [], animations: closure) {
            (didFinish) -> Void in
            self.delayTime(self.delay, closure: { () -> () in
                
            })
        }
        currentDelay += delay + animationTime
    }
    
    private func delayTime(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func cancelAnimations() {
        layer.removeAllAnimations()
    }
    
    //Enums
    
    enum Direction {
        case North
        case East
        case South
        case West
    }
    
    enum AnimationState {
        case HasNotStarted
        case Running
        case Done
    }
}

