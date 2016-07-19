//
//  GridView.swift
//  Assignment3
//
//  Created by Sam Brause on 7/7/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit
import Foundation
@IBDesignable

class GridView: UIView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
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
        grid[indeces[0]][indeces[1]] = grid[indeces[0]][indeces[1]].toggle(grid[indeces[0]][indeces[1]])
        StandardEngine.sharedInstance.grid2 = grid
        self.setNeedsDisplay()
    }
    
    @IBInspectable var cols: Int = 20{
        didSet{
            
        }
    }
    
    @IBInspectable var rows: Int = 20{
        didSet{
            
        }
    }
    
    @IBInspectable var grid = Array(count: 011340, repeatedValue: Array(count: 011340, repeatedValue: CellState.Empty))
    
    @IBInspectable var livingColor: UIColor?
    
    @IBInspectable var emptyColor: UIColor?
    
    @IBInspectable var bornColor: UIColor?
    
    @IBInspectable var diedColor: UIColor?
    
    @IBInspectable var gridColor: UIColor?
    
    @IBInspectable var gridWidth: CGFloat = 2.0
    
    override func drawRect(rect: CGRect){
        for count in 0...cols {
            let path = UIBezierPath()
            path.lineWidth = gridWidth
            
            path.moveToPoint(CGPoint(
                x:CGFloat(count)*(bounds.height/CGFloat(cols)),
                y:0.0))
            
            path.addLineToPoint(CGPoint(
                x:CGFloat(count)*(bounds.height/CGFloat(cols)),
                y:bounds.width))
            
            gridColor!.setStroke()
            
            path.stroke()
        }
        for count in 0...rows {
            let path = UIBezierPath()
            path.lineWidth = gridWidth
            
            path.moveToPoint(CGPoint(
                x:0.0,
                y:CGFloat(count)*(bounds.height/CGFloat(rows))))
            
            path.addLineToPoint(CGPoint(
                x:bounds.width,
                y:CGFloat(count)*(bounds.height/CGFloat(rows))))
            
            gridColor!.setStroke()
            
            path.stroke()
        }
        
        for index in 0..<cols{
            for index2 in 0..<rows{
                let paths = UIBezierPath(arcCenter: CGPoint(x: CGFloat(index)*bounds.width/CGFloat(cols)+bounds.width/(CGFloat(cols)*2.0), y: CGFloat(index2)*bounds.width/CGFloat(rows)+bounds.width/(CGFloat(rows)*2.0)), radius: bounds.width/max(CGFloat(rows),CGFloat(cols))/2.5, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
                //let paths = UIBezierPath(ovalInRect: rect)
                switch grid[index][index2]{
                case .Living:
                    livingColor!.setFill()
                case .Empty:
                    emptyColor!.setFill()
                case .Died:
                    diedColor!.setFill()
                default:
                    bornColor!.setFill()
                }
                paths.fill()
            }
        }
    }
    
}