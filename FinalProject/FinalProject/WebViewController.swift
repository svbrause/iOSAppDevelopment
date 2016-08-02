//
//  WebViewController.swift
//  FinalProject
//
//  Created by Sam Brause on 8/2/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBAction func showNavBar(sender: AnyObject) {
        viewWIthStuff.hidden = false
        vwsToTop.constant = 45.0
        webViewSpace.constant = 50.0
    }
    @IBOutlet weak var vwsToTop: NSLayoutConstraint!
    @IBOutlet weak var viewWIthStuff: UIView!
    @IBAction func goForward(sender: AnyObject) {
        let url = NSURL (string: next)
        let requestObj = NSURLRequest(URL: url!)
        myWebView.loadRequest(requestObj)
    }
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var viwWithoutStuff: UIView!
    @IBOutlet weak var webViewSpace: NSLayoutConstraint!
    @IBAction func pleaseGoBack(sender: AnyObject) {
        next = (myWebView.request?.URL!.absoluteString)!
        let url = NSURL (string: prev)
        let requestObj = NSURLRequest(URL: url!)
        myWebView.loadRequest(requestObj)
    }
    
    @IBAction func hideSearch(sender: AnyObject) {
        viewWIthStuff.hidden = true
        vwsToTop.constant = 2.0
        webViewSpace.constant = 20.0
    }
    
    var prev:String = "http://www.google.com/#safe=strict&q=Conway's+Game+of+Life"
    var next:String = "http://www.google.com/#safe=strict&q=Conway's+Game+of+Life"
    var search:String = "http://www.google.com/#safe=strict&q=Conway's+Game+of+Life"
    @IBAction func searchIt(sender: AnyObject) {
        searchBar.endEditing(true)
        var url = NSURL (string: "http://www.google.com")
        if search.hasPrefix("http://"){
            url = NSURL (string: search)
            prev = search
        }else if search.containsString(" "){
            url = NSURL (string: "http://www.google.com/#safe=strict&q=\(search.stringByReplacingOccurrencesOfString(" ", withString: "+"))")
            prev = "http://www.google.com/#safe=strict&q=\(search.stringByReplacingOccurrencesOfString(" ", withString: "+"))"
        }else{
            url = NSURL (string: "http://www.google.com/#safe=strict&q=\(search)")
            prev = "http://www.google.com/#safe=strict&q=\(search)"
        }
        let requestObj = NSURLRequest(URL: url!)
        myWebView.loadRequest(requestObj)
    }
    @IBAction func searchWeb(sender: UITextField) {
        search = sender.text!
    }
    @IBOutlet weak var myWebView: UIWebView!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        viewWIthStuff.hidden = false
        vwsToTop.constant = 45.0
        webViewSpace.constant = 50.0
        viewWIthStuff.layer.borderColor = UIColor.blackColor().CGColor
        let url = NSURL (string: search)
        let requestObj = NSURLRequest(URL: url!)
        myWebView.loadRequest(requestObj)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

