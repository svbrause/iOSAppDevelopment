//
//  SimulationViewController.swift
//  Assignment4
//
//  Created by Sam Brause on 7/14/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit

var timer = NSTimer()

class SimulationViewController: UIViewController, EngineDelegate {
    func engineDidUpdate(withGrid: StandardEngine, GridProtocol: NSObjectProtocol) {
        GridView3.rows = StandardEngine.sharedInstance.rows
        GridView3.cols = StandardEngine.sharedInstance.cols
        GridView3.setNeedsDisplay()
    }
    
    @IBAction func clearGrid(sender: AnyObject) {
        rejillaClara()
    }
    
    func rejillaClara(){
        for a in 0..<StandardEngine.sharedInstance.cols{
            for b in 0..<StandardEngine.sharedInstance.rows{
                GridView3.grid[a][b] = .Empty
                StandardEngine.sharedInstance.grid2[a][b] = .Empty
            }
        }
        timer.invalidate()
        start_step.setTitle("Start", forState: .Normal)
        GridView3.setNeedsDisplay()
    }
    
    @IBOutlet weak var start_step: UIButton!
    
    func step(){
        GridView3.grid = StandardEngine.sharedInstance.step(GridView3.grid)
        StandardEngine.sharedInstance.grid2 = GridView3.grid
        GridView3.setNeedsDisplay()
    }
    @IBOutlet weak var GridView3: GridView!
    
    @IBAction func Reinitialize(sender: AnyObject) {
        timer.invalidate()
        if isItOn{
            start_step.setTitle("Start", forState: .Normal)
        }else{
            start_step.setTitle("Step", forState: .Normal)
        }
        GridView3.grid = StandardEngine.sharedInstance.initialize()
        GridView3.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GridView3.rows = StandardEngine.sharedInstance.rows
        GridView3.cols = StandardEngine.sharedInstance.cols
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.printSent), name: mySpecialNotificationKey, object: nil)
        let n = NSNotification(name: mySpecialNotificationKey,
                               object: nil,
                               userInfo: ["name": "fred"])
        NSNotificationCenter.defaultCenter().postNotification(n)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if !(GridView3.rows==StandardEngine.sharedInstance.rows && GridView3.cols==StandardEngine.sharedInstance.cols){
            rejillaClara()
            GridView3.rows = StandardEngine.sharedInstance.rows
            GridView3.cols = StandardEngine.sharedInstance.cols
            GridView3.setNeedsDisplay()
        }
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)
        if isItOn {
            start_step.setTitle("Start", forState: .Normal)
        }else{
            timer.invalidate()
            start_step.setTitle("Step", forState: .Normal)
        }
    }
    
    func printSent(){
        print("sent")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Iterate(sender: AnyObject) {
        Grid.sharedInstance.rows = GridView3.cols
        Grid.sharedInstance.cols = GridView3.cols
        if isItOn{
            if(start_step.currentTitle == "Start"){
                start_step.setTitle("Stop", forState: .Normal)
                timer.invalidate()
                timer = NSTimer.scheduledTimerWithTimeInterval(StandardEngine.sharedInstance.timeInterval, target: self, selector: #selector(step), userInfo: nil, repeats: true)
            }else if(start_step.currentTitle == "Stop"){
                start_step.setTitle("Start", forState: .Normal)
                timer.invalidate()
            }
        }else{
            start_step.setTitle("Step", forState: .Normal)
            step()
        }
    }
}
