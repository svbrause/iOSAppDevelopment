//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by Sam Brause on 7/14/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit
var mySpecialNotificationKey = "com.andrewcbancroft.specialNotificationKey"
class StatisticsViewController: UIViewController {
    @IBOutlet weak var LivingCells: UILabel!
    @IBOutlet weak var BornCells: UILabel!
    @IBOutlet weak var EmptyCells: UILabel!
    @IBOutlet weak var DiedCells: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(StatisticsViewController.actOnSpecialNotification(_:)), name: mySpecialNotificationKey, object: nil)
        // Do any additional setup after loading the view.
        
    }
    
    @objc func actOnSpecialNotification(notification:NSNotification) {
        print("got it")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        LivingCells.text = "\(StandardEngine.sharedInstance.countCells()[0])"
        BornCells.text = "\(StandardEngine.sharedInstance.countCells()[1])"
        DiedCells.text = "\(StandardEngine.sharedInstance.countCells()[2])"
        EmptyCells.text = "\(StandardEngine.sharedInstance.countCells()[3])"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
