//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by Sam Brause on 6/30/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {

    @IBAction func Problem4Button(sender: AnyObject) {
        var count = 0
        var before = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
        for a in 0...9{
            for b in 0...9{
                if arc4random_uniform(3) == 1 {
                    before[a][b]=true
                    count += 1
                }
            }
        }
        let results = step2(before, count: count)
        let(_, resCount, resCount2) = results
        Problem4Text.text = "Number of living cells: \n" + "(Before) " + String(resCount) + "\n(After) " + String(resCount2)
    }
    @IBOutlet weak var Problem4Text: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Problem 4"
        Problem4Text.text = "Number of living cells: "
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
