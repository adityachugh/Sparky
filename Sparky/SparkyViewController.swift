//
//  SparkyViewController.swift
//  Sparky
//
//  Created by Aditya Chugh on 2015-03-27.
//  Copyright (c) 2015 Spark Education. All rights reserved.
//

import UIKit

class SparkyViewController: UIViewController, UIScrollViewDelegate, ErrorHandler {

    @IBOutlet weak var sparkyScrollView: UIScrollView!
    
    var edgeOffset = 8
    var cellDimension = 75
    @IBOutlet weak var numberOfCandiesButton: UIBarButtonItem!
    
    var rows = 20
    var columns = 20
    var sparky = Sparky()
    var cells = Array<Array<SparkyGridCell>>()
    var container = UIView()
    var worldGenerator = World()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sparky.errorHandler = self
        rows = worldGenerator.numberOfRows()
        columns = worldGenerator.numberOfColumns()
        generateBoard()
        sparky.cells = self.cells
        worldGenerator.cells = self.cells
        worldGenerator.sparky = self.sparky
        worldGenerator.cellDimension = self.cellDimension
        sparky.frame = CGRectMake(CGFloat(0), CGFloat(0), CGFloat(cellDimension), CGFloat(cellDimension))
        worldGenerator.generateWorld()
        self.title = worldGenerator.name
        numberOfCandiesButton.title = "\(worldGenerator.candies) Candies"
        container.addSubview(sparky)
        sparkyScrollView.minimumZoomScale = 0.25
        sparkyScrollView.maximumZoomScale = 1
        sparkyScrollView.delegate = self
    }
    
    @IBAction func runButtonPressed(sender: UIBarButtonItem) {
        sparky.startAnimation()
        if sender.title == "Stop" {
            sparky.cancelAnimations()
        }
        if sparky.animationState == SparkyCell.AnimationState.Running {
            sender.title = "Stop"
        }
    }
    
    func generateBoard() {
        for var index = 0; index < columns; ++index {
            var array = Array<SparkyGridCell>()
            for var indexj = 0; indexj < rows; ++indexj {
                var cell = SparkyGridCell()
                array.append(cell)
            }
            cells.append(array)
        }
        for var i = 0; i < columns; ++i {
            for var j = 0; j < rows; ++j {
                var cell = cells[i][j]
                var x = CGFloat(i*cellDimension)
                var y = CGFloat(j*cellDimension)
                cell.errorHandler = self
                cell.frame = CGRectMake(x, y, CGFloat(cellDimension), CGFloat(cellDimension))
                cell.coordinate = CGPointMake(CGFloat(i), CGFloat(j))
                container.addSubview(cell)
            }
        }
        self.sparky.cells = self.cells
        container.frame = CGRectMake(CGFloat(edgeOffset), CGFloat(edgeOffset), CGFloat(columns*cellDimension), CGFloat(rows*cellDimension))
        sparkyScrollView.addSubview(container)
        sparkyScrollView.contentSize = CGSizeMake(CGFloat(edgeOffset*2+columns*cellDimension), CGFloat(edgeOffset*2+rows*cellDimension))
    }
    
    @IBAction func speedButtonpressed(sender: UIBarButtonItem) {
        
    }
    
    @IBAction func speedChanged(sender: UISlider) {
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return container
    }
    
    func errorOccured(description: String) {
        sparky.cancelAnimations()
        var alert = UIAlertController(title: "Error", message: description, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

protocol ErrorHandler {
    func errorOccured(description: String)
}