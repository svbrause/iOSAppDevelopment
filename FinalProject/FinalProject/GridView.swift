//
//  GridView.swift
//  FinalProject
//
//  Created by Sam Brause on 7/30/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit
var inSim = false
@IBDesignable class GridView: UIView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(!inPong){
            let touch: UITouch = touches.first!
            let point = touch.locationInView(self)
            var indeces = Array(count: 2, repeatedValue: 0)
            for a in 0..<Int(bounds.height){
                for b in 0..<Int(bounds.width){
                    if(Int((point.x))==a&&Int((point.y))==b){
                        indeces[0] = a
                        indeces[1] = b
                    }
                }
            }
            indeces[0] = Int((Double(indeces[0])/(Double(bounds.height)/Double(cols))))
            indeces[1] = Int((Double(indeces[1])/(Double(bounds.width)/Double(rows))))
            grid[indeces[1],indeces[0]] = grid[indeces[1],indeces[0]].toggle(grid[indeces[1],indeces[0]])
            StandardEngine.sharedInstance.grid = grid
            self.setNeedsDisplayInRect(CGRect(x: CGFloat(Double(indeces[0])*Double(bounds.height)/Double(cols)), y: CGFloat(Double(indeces[1])*Double(bounds.width)/Double(rows)), width: CGFloat(Double(bounds.height)/Double(cols)), height: CGFloat(Double(bounds.width)/Double(rows))))
        }
    }
    var cols: Int {
        get {
            return calculateSize()
        }
        set {
            guard StandardEngine.sharedInstance.configuration == nil else { return }
            StandardEngine.sharedInstance.cols = newValue
        }
    }
    
    var rows: Int {
        get {
            return calculateSize()
        }
        set {
            guard StandardEngine.sharedInstance.configuration == nil else { return }
            StandardEngine.sharedInstance.rows = newValue
        }
    }
    
//    @IBInspectable var grid3 = Array(count: 011340, repeatedValue: Array(count: 011340, repeatedValue: CellState.Empty))
    
    @IBInspectable var livingColor: UIColor?
    
    @IBInspectable var emptyColor: UIColor?
    
    @IBInspectable var bornColor: UIColor?
    
    @IBInspectable var diedColor: UIColor?
    
    @IBInspectable var gridColor: UIColor?
    
    @IBInspectable var gridWidth: CGFloat = 2.0
    
    var grid: GridProtocol {
        get {
            if let configuration = StandardEngine.sharedInstance.configuration {
                let newGrid = Grid(rows, cols) { position in
                    return configuration.positions.contains({ return position.row == $0.row && position.col == $0.col }) ? .Living : .Empty
                }
                
                return newGrid
            }
            
            return StandardEngine.sharedInstance.grid
        }
        set {
            if let _ = StandardEngine.sharedInstance.configuration {
                let positions = newValue.cells.reduce([]) { (array, cell) -> [Position] in
                    if cell.state == .Living {
                        return array + [cell.position]
                    }
                    return array
                }
                
                StandardEngine.sharedInstance.configuration!.positions = positions
            } else {
                StandardEngine.sharedInstance.grid = newValue
            }
        }
    }
    
    func calculateSize() -> Int {
        if(!inSim){
            if let configuration = StandardEngine.sharedInstance.configuration {
                let maxRow = configuration.positions.map { $0.row }.maxElement()!
                let maxCol = configuration.positions.map { $0.col }.maxElement()!
            
                var size: Int = 20 // default is 20 by 20
            
                size = max(maxRow, maxCol) + 1    // give it a margin of space
                if size > 100 {
                    size = 100   // we will limit it at 100 by 100
                }
            
                return size
            }
        }
        return max(StandardEngine.sharedInstance.rows, StandardEngine.sharedInstance.cols)
    }
    
    var points: [Position] {
        set {
            // set the row and col from that - double the maximum
            let newGrid = Grid(rows, cols) { position in
                return newValue.contains({ return position.row == $0.row && position.col == $0.col }) ? .Living : .Empty
            }
            
            grid = newGrid
            
            // send EngineUpdate notification
            if let delegate = StandardEngine.sharedInstance.delegate {
                delegate.engineDidUpdate(grid)
            }
        }
        
        get {
            // return array of all alive cells (includes born, living, diseased)
            return grid.cells.reduce([]) { (array, cell) -> [Position] in
                if cell.state == .Living {
                    return array + [cell.position]
                }
                return array
            }
        }
    }
    
    override func drawRect(rect: CGRect){
        let cellWidth: CGFloat = self.frame.size.width / CGFloat(cols)
        let cellHeight: CGFloat = self.frame.size.height / CGFloat (rows)
        
        
        // draw gridlines
        let gridLines = UIBezierPath()
        
        gridLines.lineWidth = gridWidth
        
        for col in 0...cols {
            gridLines.moveToPoint(CGPoint(x: CGFloat(col) * cellWidth, y: 0))
            gridLines.addLineToPoint(CGPoint(x: CGFloat(col) * cellWidth, y: CGFloat(rows) * cellHeight))
        }
        
        for row in 0...rows {
            gridLines.moveToPoint(CGPoint(x: 0, y: CGFloat(row) * cellHeight))
            gridLines.addLineToPoint(CGPoint(x: CGFloat(cols) * cellWidth, y: CGFloat(row) * cellHeight))
        }
        
        gridColor!.setStroke()
        gridLines.stroke()
        
        // draw all circles in cells
        for col in 0..<cols {
            for row in 0..<rows {
                let aCell = CGRectMake(CGFloat(col)*cellWidth + gridWidth/2, CGFloat(row)*cellHeight + gridWidth/2, cellWidth - gridWidth, cellHeight - gridWidth)
                
                let circle = UIBezierPath(ovalInRect: aCell)
                var cellColor: UIColor
                switch (grid.cells[row * cols + col].state) {
                case .Living:
                    cellColor = livingColor!
                case .Empty:
                    cellColor = emptyColor!
                case .Born:
                    cellColor = bornColor!
                case .Died:
                    cellColor = diedColor!
                }
                cellColor.setFill()
                circle.fill()
            }
        }

        
//        for count in 0...cols {
//            let path = UIBezierPath()
//            path.lineWidth = gridWidth
//            
//            path.moveToPoint(CGPoint(
//                x:CGFloat(count)*(bounds.height/CGFloat(cols)),
//                y:0.0))
//            
//            path.addLineToPoint(CGPoint(
//                x:CGFloat(count)*(bounds.height/CGFloat(cols)),
//                y:bounds.width))
//            
//            gridColor!.setStroke()
//            
//            path.stroke()
//        }
//        for count in 0...rows {
//            let path = UIBezierPath()
//            path.lineWidth = gridWidth
//            
//            path.moveToPoint(CGPoint(
//                x:0.0,
//                y:CGFloat(count)*(bounds.height/CGFloat(rows))))
//            
//            path.addLineToPoint(CGPoint(
//                x:bounds.width,
//                y:CGFloat(count)*(bounds.height/CGFloat(rows))))
//            
//            gridColor!.setStroke()
//            
//            path.stroke()
//        }
//        
//        for index in 0..<cols{
//            for index2 in 0..<rows{
//                let paths = UIBezierPath(arcCenter: CGPoint(x: CGFloat(index)*bounds.width/CGFloat(cols)+bounds.width/(CGFloat(cols)*2.0), y: CGFloat(index2)*bounds.width/CGFloat(rows)+bounds.width/(CGFloat(rows)*2.0)), radius: bounds.width/max(CGFloat(rows),CGFloat(cols))/2.5, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
//                switch grid[index][index2]{
//                case .Living:
//                    livingColor!.setFill()
//                case .Empty:
//                    emptyColor!.setFill()
//                case .Died:
//                    diedColor!.setFill()
//                default:
//                    bornColor!.setFill()
//                }
//                paths.fill()
//            }
//        }
    }
    
}