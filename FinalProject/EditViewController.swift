//
//  EditViewController.swift
//  FinalProject
//
//  Created by Sam Brause on 8/1/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import Foundation

import UIKit

class EditViewController: UIViewController {
    
    var name:String?
    var commit: (String -> Void)?
    
    @IBAction func save(sender: AnyObject) {
        guard let newText = nameTextField.text, commit = commit
            else{ return }
        commit(newText)
        navigationController!.popViewControllerAnimated(true)
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = name
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
