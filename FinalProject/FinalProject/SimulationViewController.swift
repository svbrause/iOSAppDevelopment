//
//  SecondViewController.swift
//  FinalProject
//
//  Created by Sam Brause on 7/29/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit

var timer = NSTimer()

class SimulationViewController: UIViewController, EngineDelegate {

    var configurations:Array<Configuration>{
        get{
            return StandardEngine.sharedInstance.configurations
        }set{
            StandardEngine.sharedInstance.configurations = newValue
        }
    }
    
    @IBAction func addConfiguration(sender: AnyObject) {
        configurations.append(Configuration(title: "Add new name...", positions: []))
        let itemRow = configurations.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        ConfigurationViewController.sharedInstance.tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }
    
    @IBAction func clearGrid(sender: AnyObject) {
        rejillaClara()
    }
    
    func rejillaClara(){
        for a in 0..<StandardEngine.sharedInstance.cols{
            for b in 0..<StandardEngine.sharedInstance.rows{
                GridView3.grid[b,a] = .Empty
                StandardEngine.sharedInstance.grid[b,a] = .Empty
            }
        }
        timer.invalidate()
        if isItOn{
            start_step.setTitle("Start", forState: .Normal)
        }else{
            start_step.setTitle("Step", forState: .Normal)
        }
        GridView3.setNeedsDisplay()
    }
    
    @IBOutlet weak var start_step: UIButton!
    
    func step(){
        GridView3.grid = StandardEngine.sharedInstance.step()
        //StandardEngine.sharedInstance.grid2 = GridView3.grid3
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
        self.title = "Game Of Life"
        GridView3.rows = StandardEngine.sharedInstance.rows
        GridView3.cols = StandardEngine.sharedInstance.cols
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SimulationViewController.printSent), name: mySpecialNotificationKey, object: nil)
        let n = NSNotification(name: mySpecialNotificationKey,
                               object: nil,
                               userInfo: ["name": "fred"])
        NSNotificationCenter.defaultCenter().postNotification(n)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        inSim = false
        timer.invalidate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        inSim = true
        if(inPong){
            rejillaClara()
            inPong = false
        }
        if !(GridView3.rows==StandardEngine.sharedInstance.rows && GridView3.cols==StandardEngine.sharedInstance.cols){
            GridView3.rows = StandardEngine.sharedInstance.rows
            GridView3.cols = StandardEngine.sharedInstance.cols
            rejillaClara()
        }
        NSNotificationCenter.defaultCenter().postNotificationName("NotificationIdentifier", object: nil)
        if isItOn {
            start_step.setTitle("Start", forState: .Normal)
        }else{
            timer.invalidate()
            start_step.setTitle("Step", forState: .Normal)
        }
        StandardEngine.sharedInstance.delegate = self
        GridView3.setNeedsDisplay()
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        GridView3.setNeedsDisplay()
    }
    
    func printSent(){
        print("sent")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Iterate(sender: AnyObject) {
        //Grid.sharedInstance.rows = GridView3.cols
        //Grid.sharedInstance.cols = GridView3.cols
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
