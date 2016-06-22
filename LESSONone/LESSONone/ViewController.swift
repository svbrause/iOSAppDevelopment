//
//  ViewController.swift
//  LESSONone
//
//  Created by Cheryl Brause on 6/20/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userName: UITextField!{
        didSet{
            userName.delegate = self
        }
    }
    
    @IBAction func greetMeTapped(sender: AnyObject) {
        print("Greeting was tapped")
        if let greetingp = userName.text{
            let greeting = "Hello, \(greetingp)"
            greetingLabel.text = greeting
        }
    }
    
    @IBOutlet weak var greetingLabel: UILabel!
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        greetingLabel.text = "Hello, \(userName.text!)"
        return true
    }

}

