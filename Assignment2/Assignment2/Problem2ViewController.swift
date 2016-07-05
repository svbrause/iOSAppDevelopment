//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by Sam Brause on 6/30/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit

class Problem2ViewController: UIViewController {

    @IBOutlet weak var Problem2Text: UITextView!
    @IBAction func Problem2Button(sender: AnyObject) {
        var count = 0
        var before = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
        var after = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: false))
        for a in 0...9{
            for b in 0...9{
                if arc4random_uniform(3) == 1 {
                    before[a][b]=true
                    count+=1
                }
            }
        }
        Problem2Text.text = "Number of living cells: \n" + "(Before) " + String(count) 
        var neighbors = Array(count: 10, repeatedValue: Array(count: 10, repeatedValue: 0))
        for a in 0...9{
            for b in 0...9{
                    switch true{
                        case (a>0&&a<9&&b<9):
                            switch true{
                                case b>0:
                                    if(before[a+1][b-1]){
                                        neighbors[a][b] += 1
                                    }
                                    if(before[a-1][b-1]){
                                        neighbors[a][b] += 1
                                    }
                                    if(before[a][b-1]){
                                        neighbors[a][b] += 1
                                    }
                                    fallthrough
                                default:
                                    if(before[a-1][b+1]){
                                        neighbors[a][b] += 1
                                    }
                                    if(before[a][b+1]){
                                        neighbors[a][b] += 1
                                    }
                                    if(before[a+1][b]){
                                        neighbors[a][b] += 1
                                    }
                                    if(before[a-1][b]){
                                        neighbors[a][b] += 1
                                    }
                                    if(before[a+1][b+1]){
                                        neighbors[a][b] += 1
                                    }
                        }
                    case (b>0&&a<9&&b<9):
                        switch true{
                            case a>0:
                                if(before[a-1][b+1]){
                                    neighbors[a][b] += 1
                                }
                                if(before[a-1][b-1]){
                                    neighbors[a][b] += 1
                                }
                                if(before[a-1][b]){
                                    neighbors[a][b] += 1
                                }
                                fallthrough
                            default:
                                if(before[a+1][b+1]){
                                    neighbors[a][b] += 1
                                }
                                if(before[a+1][b-1]){
                                    neighbors[a][b] += 1
                                }
                                if(before[a][b-1]){
                                    neighbors[a][b] += 1
                                }
                                if(before[a][b+1]){
                                    neighbors[a][b] += 1
                                }
                                if(before[a+1][b]){
                                    neighbors[a][b] += 1
                                }
                        }
                case (a==0&&b>0):
                    switch true{
                        case b<9:
                            if(before[a+1][b+1]){
                                neighbors[a][b] += 1
                            }
                            if(before[a+9][b+1]){
                                neighbors[a][b] += 1
                            }
                            if(before[a][b+1]){
                                neighbors[a][b] += 1
                            }
                            fallthrough
                        case b==9:
                            if(b==9){
                                if(before[a+1][b-9]){
                                    neighbors[a][b] += 1
                                }
                                if(before[a+9][b-9]){
                                    neighbors[a][b] += 1
                                }
                                if(before[a][b-9]){
                                    neighbors[a][b] += 1
                                }
                            }
                            fallthrough
                        default:
                            if(before[a+1][b-1]){
                                neighbors[a][b] += 1
                            }
                            if(before[a+9][b-1]){
                                neighbors[a][b] += 1
                            }
                            if(before[a][b-1]){
                                neighbors[a][b] += 1
                            }
                            if(before[a+1][b]){
                                neighbors[a][b] += 1
                            }
                            if(before[a+9][b]){
                                neighbors[a][b] += 1
                            }
                        }
                case (b==0&&a>0):
                    switch true{
                        case a<9:
                            if(before[a+1][b+1]){
                                neighbors[a][b] += 1
                            }
                            if(before[a+1][b+9]){
                                neighbors[a][b] += 1
                            }
                            if(before[a+1][b]){
                                neighbors[a][b] += 1
                            }
                            fallthrough
                        case a==9:
                            if(a==9){
                                if(before[a-9][b+1]){
                                    neighbors[a][b] += 1
                                }
                                if(before[a-9][b+9]){
                                    neighbors[a][b] += 1
                                }
                                if(before[a-9][b]){
                                    neighbors[a][b] += 1
                                }
                            }
                            fallthrough
                        default:
                            if(before[a-1][b+1]){
                                neighbors[a][b] += 1
                            }
                            if(before[a-1][b+9]){
                                neighbors[a][b] += 1
                            }
                            if(before[a][b+9]){
                                neighbors[a][b] += 1
                            }
                            if(before[a][b+1]){
                                neighbors[a][b] += 1
                            }
                            if(before[a-1][b]){
                                neighbors[a][b] += 1
                            }
                        }
                case (b==0&&a==0):
                    if(before[a+1][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+9][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+1][b+9]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+9][b+9]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b+9]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b+1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+1][b]){
                        neighbors[a][b] += 1
                    }
                    if(before[a+9][b]){
                        neighbors[a][b] += 1
                    }
                case (b==9&&a==9):
                    if(before[a-9][b-9]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-1][b-9]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-9][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-1][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b-1]){
                        neighbors[a][b] += 1
                    }
                    if(before[a][b-9]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-9][b]){
                        neighbors[a][b] += 1
                    }
                    if(before[a-1][b]){
                        neighbors[a][b] += 1
                    }
                    default:
                        break
                }
            }
        }
        for a in 0...9{
            for b in 0...9{
                if(before[a][b]){
                    if(neighbors[a][b]<2){
                        after[a][b]=false
                    }else if(neighbors[a][b]>1&&neighbors[a][b]<4){
                        after[a][b]=true
                    }else if(neighbors[a][b]>3){
                        after[a][b]=false
                    }
                }else{
                    if(neighbors[a][b]==3){
                        after[a][b]=true
                    }else{
                        after[a][b]=false
                    }
                }
            }
        }
        var count2=0
        for a in 0...9{
            for b in 0...9{
                if(after[a][b]){
                    count2+=1
                }
            }
        }
        Problem2Text.text = "Number of living cells:\n (before) " + String(count) + "\n (after) " + String(count2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Problem 2"
        Problem2Text.text = "Number of living cells: "
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
