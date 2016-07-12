//
//  GridView.swift
//  Assignment3
//
//  Created by Sam Brause on 7/7/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit

@IBDesignable

class GridView: UIView {
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch: UITouch = touches.first!
        let point = touch.locationInView(self)
        var indeces = Array(count: Int(max(bounds.height,bounds.width)), repeatedValue: 0)
        for a in 0..<Int(bounds.height){
            for b in 0..<Int(bounds.width){
                if(point==CGPoint(x: a,y: b)){
                    indeces[0] = a
                    indeces[1] = b
                }
            }
        }
        indeces[0] /= Int(ceil(Double(bounds.height)/Double(cols)))
        indeces[1] /= Int(ceil(Double(bounds.width)/Double(rows)))
        grid[indeces[0]][indeces[1]] = grid[indeces[0]][indeces[1]].toggle(grid[indeces[0]][indeces[1]])
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
    
    @IBInspectable var grid = Array(count: 01134, repeatedValue: Array(count: 01134, repeatedValue: CellState.Empty))
    
    @IBInspectable var livingColor: UIColor?{
        didSet{
            layer.backgroundColor = UIColor.blackColor().CGColor
        }
    }
    
    @IBInspectable var emptyColor: UIColor?{
        didSet{
            layer.backgroundColor = UIColor.blueColor().CGColor
        }
    }
    
    @IBInspectable var bornColor: UIColor?{
        didSet{
            layer.backgroundColor = UIColor.cyanColor().CGColor
        }
    }
    
    @IBInspectable var diedColor: UIColor?{
        didSet{
            layer.backgroundColor = UIColor.greenColor().CGColor
        }
    }
    
    @IBInspectable var gridColor: UIColor?{
        didSet{
            layer.backgroundColor = UIColor.whiteColor().CGColor
        }
    }
    
    @IBInspectable var gridWidth: CGFloat = 2.0
    
    override func drawRect(rect: CGRect){
        var count = 0
        
        while count<=cols {
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
            count+=1
            
        }
        count=0
        while count<=rows {
            let path = UIBezierPath()
            path.lineWidth = gridWidth
            
            path.moveToPoint(CGPoint(
                x:0.0,
                y:1.0+CGFloat(count)*(bounds.height/CGFloat(rows))))
            
            path.addLineToPoint(CGPoint(
                x:bounds.width,
                y:1.0+CGFloat(count)*(bounds.height/CGFloat(rows))))
            
            gridColor!.setStroke()
            
            path.stroke()
            count+=1
        }
        let path = UIBezierPath()
        path.lineWidth = gridWidth
        path.moveToPoint(CGPoint(
            x:0.0,
            y:bounds.height-1))
        path.addLineToPoint(CGPoint(
            x:bounds.width,
            y:bounds.height-1))
        gridColor!.setStroke()
        path.stroke()
        count+=1
        
        for index in 0..<cols{
            for index2 in 0..<rows{
                let paths = UIBezierPath(arcCenter: CGPoint(x: CGFloat(index)*bounds.width/CGFloat(cols)+bounds.width/(CGFloat(cols)*2.0), y: CGFloat(index2)*bounds.width/CGFloat(rows)+bounds.width/(CGFloat(rows)*2.0)+1), radius: bounds.width/CGFloat(rows)/2.5, startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
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