//
//  PushButtonView.swift
//  TryingOutGraphics
//
//  Created by Cheryl Brause on 7/6/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit
@IBDesignable
class PushButtonView: UIButton {
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        UIColor.blueColor().setFill()
        path.fill()
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight: CGFloat = min(bounds.width, bounds.height) * 0.1
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        
        //create the path
        var plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth/2,
            y:bounds.height/2))
        
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2,
            y:bounds.height/2))
        
        //set the stroke color
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
        
        //---------------------------------------------------------------------------------
        
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight2: CGFloat = max(bounds.width, bounds.height) * 0.6
        let plusWidth2: CGFloat = 1.0

        
        //create the path
        var plusPath2 = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath2.lineWidth = plusHeight2
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath2.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth2/2,
            y:bounds.height/2))
        
        //add a point to the path at the end of the stroke
        plusPath2.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth2/2,
            y:bounds.height/2))
        
        //set the stroke color
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        plusPath2.stroke()
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
