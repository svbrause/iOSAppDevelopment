//
//  TableView.swift
//  FinalProject
//
//  Created by Sam Brause on 8/1/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit

struct Configuration {
    var title: String
    var positions: Array<Position>
    
    static func fromJSON(json: Dictionary<String, AnyObject>) -> Configuration {
        let title = json["title"] as! String
        
        let contents = json["contents"] as! Array<Array<Int>>
        
        let positions = contents.map { (intArray) -> Position in
            return Position(intArray.first!, intArray.last!)
        }
        
        return Configuration(title: title, positions: positions)
    }
}

class ConfigurationViewController: UITableViewController, EngineDelegate {
    private static var _sharedInstance = ConfigurationViewController()
    static var sharedInstance: ConfigurationViewController {
        return _sharedInstance
    }
    
    var configurations:Array<Configuration>{
        get{
            return StandardEngine.sharedInstance.configurations
        }set{
            StandardEngine.sharedInstance.configurations = newValue
        }
    }
    func engineDidUpdate(withGrid: NSObjectProtocol) {
        //do nothing
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
        let fetcher = Fetcher()
        fetcher.requestJSON(url) { (json, message) in
            if let json = json, array = json as? Array<Dictionary<String,AnyObject>>{
                self.configurations = array.map({(dict) -> Configuration in
                    return Configuration.fromJSON(dict)
                })
                
                let op = NSBlockOperation{
                    self.tableView.reloadData()
                }
                NSOperationQueue.mainQueue().addOperation(op)
            }
        }
//        loadConfigurations("https://dl.dropboxusercontent.com/u/7544475/S65g.json")
    }
    func loadConfigurations(urlString: String){
        let url = NSURL(string: urlString)!
        let fetcher = Fetcher()
        fetcher.requestJSON(url) { (json, message) in
            if let json = json, array = json as? Array<Dictionary<String,AnyObject>>{
                self.configurations = array.map({(dict) -> Configuration in
                    return Configuration.fromJSON(dict)
                })
                
                let op = NSBlockOperation{
                    self.tableView.reloadData()
                }
                NSOperationQueue.mainQueue().addOperation(op)
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        StandardEngine.sharedInstance.configurationIndex = nil
        StandardEngine.sharedInstance.delegate=self
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        //
    }
    
    func engineDidUpdate(withConfigurations: Array<Configuration>) {
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addConfiguration(sender: AnyObject) {
        configurations.append(Configuration(title: "Add new name...", positions: []))
        let itemRow = configurations.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }
    
    //MARK: UITableViewDelegation
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Default")
            else {
                preconditionFailure("missing Default reuse identifier")
        }
        let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("wtf?")
        }
        nameLabel.text = configurations[row].title
        cell.tag = row
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                                               forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            configurations.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editingRow = (sender as! UITableViewCell).tag
        guard let editingVC = segue.destinationViewController as? ConfigurationEditorViewController
            else {
                preconditionFailure("Another wtf?")
        }
        StandardEngine.sharedInstance.configurationIndex = editingRow
        editingVC.configuration = configurations[editingRow]
        editingVC.commit = {
            StandardEngine.sharedInstance.configurations[editingRow].title = $0
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                  withRowAnimation: .Automatic)
        }
    }
}