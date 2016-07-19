//
//  InstrumentationViewController.swift
//  Assignment4
//
//  Created by Sam Brause on 7/14/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit

var isItOn: Bool = true

class InstrumentationViewController: UIViewController {
    
    @IBAction func NumOfCols(sender: UITextField) {
        if let text = sender.text  {
            StandardEngine.sharedInstance.cols = Int(text)!
        }
    }
    
    @IBAction func numOfRows(sender: UITextField) {
        if let text = sender.text  {
            StandardEngine.sharedInstance.rows = Int(text)!
        }
    }
    @IBAction func stateChanged(sender: AnyObject) {
        if timedRefresh.on{
            isItOn = true
        }else{
            isItOn = false
        }
    }
    @IBOutlet weak var SpeedLabel: UILabel!
    
    @IBAction func subtractFromRows(sender: AnyObject) {
        StandardEngine.sharedInstance.rows -= 1
        numRows.text = String(StandardEngine.sharedInstance.rows)
    }
    @IBAction func subtractFromColumns(sender: AnyObject) {
        StandardEngine.sharedInstance.cols -= 1
        numCols.text = String(StandardEngine.sharedInstance.cols)
    }
    
    private static var _sharedInstance = InstrumentationViewController()
    static var sharedInstance: InstrumentationViewController {
        get{
            return _sharedInstance
        }
    }
    
    @IBAction func refreshRate(sender: UISlider) {
        if timedRefresh.on{
            let hertz = sender.value
            SpeedLabel.text = "\(hertz) Hz"
            let interval = 1.0/hertz
            StandardEngine.sharedInstance.timeInterval = Double(interval)
            timer.invalidate()
        }else{
            let alertController = UIAlertController(title: "Error", message:
                "Please turn timed refresh on in order to toggle refresh rate.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var timedRefresh: UISwitch!
    
    @IBAction func addToCols(sender: AnyObject) {
        StandardEngine.sharedInstance.cols += 1
        numCols.text = String(StandardEngine.sharedInstance.cols)
    }

    @IBAction func addToRows(sender: AnyObject) {
        StandardEngine.sharedInstance.rows += 1
        numRows.text = String(StandardEngine.sharedInstance.rows)
    }

    @IBOutlet weak var numCols: UITextField!
    
    @IBOutlet weak var numRows: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

