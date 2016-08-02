//
//  PongViewController.swift
//  FinalProject
//
//  Created by Sam Brause on 7/30/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit
var inPong = false
class PongViewController: UIViewController {

    var p1Score = 0
    var p2Score = 0
    var p1Val = 0
    var p2Val = 0
    var p1Max = 12
    var p1Min = 6
    var p2Max = 12
    var p2Min = 6
    var ballPosition = (10,12)
    var prevPos = (10,12)
    var p1Paddle = Array(count: 6, repeatedValue: 0)
    var p2Paddle = Array(count: 6, repeatedValue: 0)
    var bp0 = 1
    var bp1 = 1
    var timeInterval = 0.01
    var timer = NSTimer()
    var cellWidth:CGFloat = 0.0
    var cellHeight:CGFloat = 0.0
    
    @IBOutlet var viewWithToggles: UIView!
    @IBOutlet var changeNumPlayers: UISwitch!
    @IBOutlet var GridView3: GridView!
    @IBOutlet var whoWon: UILabel!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var OneOrTwoLabel: UILabel!
    @IBOutlet var p2Size: UISlider!
    @IBOutlet var p1Size: UISlider!
    
    @IBAction func OneOrTwo(sender: UISwitch) {
        if sender.on{
            OneOrTwoLabel.text = "2 Player Mode"
            p2Size.hidden = false
        }else{
            OneOrTwoLabel.text = "1 Player Mode"
            p2Size.hidden = true
        }
    }
    
    @IBAction func player1Slider(sender: UISlider) {
        if Int(floor(sender.value))>p1Val {
            p1Max = 12 + Int(floor(sender.value))
            p1Min = 6 + Int(floor(sender.value))
            for i in 0..<GridView3.cols{
                GridView3.grid[GridView3.rows-1,i] = .Empty
            }
            for i in p1Min+1...p1Max{
                GridView3.grid[GridView3.rows-1,i] = .Living
                p1Paddle[i-p1Min-1] = i
            }
        }else if Int(floor(sender.value))<p1Val{
            for i in 0..<GridView3.cols{
                GridView3.grid[GridView3.rows-1,i] = .Empty
            }
            for i in p1Min..<p1Max{
                GridView3.grid[GridView3.rows-1,i] = .Living
                p1Paddle[i-p1Min] = i
            }
            p1Max = 12 + Int(floor(sender.value))
            p1Min = 6 + Int(floor(sender.value))
        }
        p1Val = Int(floor(sender.value))
        GridView3.setNeedsDisplayInRect(CGRect(x: 0, y: (GridView3.bounds.height/CGFloat(GridView3.rows)*CGFloat(GridView3.rows-1)), width: GridView3.bounds.width, height:GridView3.bounds.height/CGFloat(GridView3.rows)))
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        resetPaddles()
        inPong = true
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
        resetPaddles()
        viewWithToggles.hidden = true
        startButton.setTitle("Start", forState: .Normal)
    }
    var keepTrackOfBorders=0
    func moveAI(timeToChangeItUp: Bool){
        let queue = NSOperationQueue()
        queue.addOperationWithBlock() {
            if self.bp0>0 {
                if(self.p2Min<self.GridView3.cols-1&&self.p2Max<self.GridView3.cols-1&&self.keepTrackOfBorders>0){
                    self.p2Max += 1
                    self.p2Min += 1
                }else{
                    self.keepTrackOfBorders += 1
                }
                for i in 0..<self.GridView3.cols{
                     self.GridView3.grid[0,i] = .Empty
                }
//                print("p2Min: \(self.p2Min) p2Max: \(self.p2Max)")
                for i in self.p2Min+1...self.p2Max{
                    self.GridView3.grid[0,i] = .Living
                    self.p2Paddle[i-self.p2Min-1] = i
                }
            }else if self.bp0<0 {
                for i in 0..<self.GridView3.cols{
                    self.GridView3.grid[0,i] = .Empty
                }
                for i in self.p2Min..<self.p2Max{
                    self.GridView3.grid[0,i] = .Living
                    self.p2Paddle[i-self.p2Min] = i
                }
                if(self.p2Max>0&&self.p2Min>0&&self.keepTrackOfBorders<self.GridView3.cols-1){
                    self.p2Max -= 1
                    self.p2Min -= 1
                }else{
                    self.keepTrackOfBorders -= 1
                }
            }
        }
        NSOperationQueue.mainQueue().addOperationWithBlock() {
            self.GridView3.setNeedsDisplayInRect(CGRect(x: 0, y: 0, width: self.GridView3.bounds.width, height:self.GridView3.bounds.height/CGFloat(self.GridView3.rows)))
        }
    }
    
    @IBAction func player2Slider(sender: UISlider) {
        if(OneOrTwoLabel.text=="2 Player Mode"){
            if Int(floor(sender.value))>p2Val {
                p2Max = 12 + Int(floor(sender.value))
                p2Min = 6 + Int(floor(sender.value))
                for i in 0..<GridView3.cols{
                    GridView3.grid[0,i] = .Empty
                }
                for i in p2Min+1...p2Max{
                    GridView3.grid[0,i] = .Living
                    p2Paddle[i-p2Min-1] = i
                }
            }else if Int(floor(sender.value))<p2Val{
                for i in 0..<GridView3.cols{
                    GridView3.grid[0,i] = .Empty
                }
                for i in p2Min..<p2Max{
                    GridView3.grid[0,i] = .Living
                    p2Paddle[i-p2Min] = i
                }
                p2Max = 12 + Int(floor(sender.value))
                p2Min = 6 + Int(floor(sender.value))
            }
            p2Val = Int(floor(sender.value))
            GridView3.setNeedsDisplayInRect(CGRect(x: 0, y: 0, width: GridView3.bounds.width, height:GridView3.bounds.height/CGFloat(GridView3.rows)))
        }
    }
    
    func resetPaddles(){
        for i in 0..<GridView3.cols{
            GridView3.grid[0,i] = .Empty
            GridView3.grid[GridView3.rows-1,i] = .Empty
        }
        for i in p1Min..<p1Max{
            GridView3.grid[GridView3.rows-1,i+1] = .Living
            p1Paddle[i-p1Min] = i
        }
        if OneOrTwoLabel.text=="2 Player Mode"{
            for i in p2Min..<p2Max{
                GridView3.grid[0,i+1] = .Living
                p2Paddle[i-p2Min] = i
            }
        }else{
            for i in GridView3.cols/2-3..<GridView3.cols/2+3{
                GridView3.grid[0,i+1] = .Living
                p2Paddle[i-GridView3.cols/2+3] = i
            }
        }
        GridView3.setNeedsDisplay()
    }
    
    @IBAction func StartTimer(sender: AnyObject) {
        if startButton.currentTitle == "Start"{
            viewWithToggles.hidden = true
            bp0=1
            bp1=1
            timeInterval=0.4
            ballPosition = (10,10)
            bp0=0
            bp1=1
            resetPaddles()
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(moveBall), userInfo: nil, repeats: true)
            startButton.setTitle("", forState: .Normal)
        }
    }
    
    func startTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(moveBall), userInfo: nil, repeats: true)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        GridView3.rows = 20
        GridView3.cols = 20
    }
    func moveBall(){
        cellHeight=(GridView3.bounds.height/CGFloat(GridView3.rows))
        cellWidth=(GridView3.bounds.width/CGFloat(GridView3.cols))
        var justDid = false
        var isTouchingP1 = false
        var isTouchingP2 = false
        let whereP1 = p1Paddle.map({(num:Int)->Bool in if(ballPosition.0==num){isTouchingP1=true}; return ballPosition.0==num})
        let whereP2 = p2Paddle.map({(num:Int)->Bool in if(ballPosition.0==num){isTouchingP2=true}; return ballPosition.0==num})
        if(ballPosition.0==0){
            bp0 = 1
        }else if(ballPosition.1==1&&isTouchingP2){
            if(whereP2[0]||whereP2[1]){
                bp0 = -1
            }else if(whereP2[2]||whereP2[3]){
                bp0 = 0
            }else{
                bp0 = 1
            }
            bp1 = 1
            timer.invalidate()
            if(timeInterval>0.02){
                timeInterval-=0.02
            }else if(timeInterval==0.02){
                timeInterval-=0.01
            }else if(timeInterval<0.02&&timeInterval>0.001){
                timeInterval-=0.001
            }else if(timeInterval<=0.001&&timeInterval>=0.0001){
                timeInterval-=0.0001
            }
            startTimer()
            justDid=true
        }else if(ballPosition.0==GridView3.cols-1){
            bp0 = -1
        }else if(ballPosition.1==GridView3.rows-2&&isTouchingP1){
            if(whereP1[0]||whereP1[1]){
                bp0 = -1
            }else if(whereP1[2]||whereP1[3]){
                bp0 = 0
            }else{
                bp0 = 1
            }
            bp1 = -1
            timer.invalidate()
            if(timeInterval>0.02){
                timeInterval-=0.02
            }else if(timeInterval==0.02){
                timeInterval-=0.01
            }else if(timeInterval<0.02&&timeInterval>0.001){
                timeInterval-=0.001
            }else if(timeInterval<=0.001&&timeInterval>=0.0001){
                timeInterval-=0.0001
            }
            startTimer()
            justDid=true
        }else if(ballPosition.1==0){
            timer.invalidate()
            p1Score+=1
            whoWon.text = "Player 1: \(p1Score)      Player 2: \(p2Score)"
            startButton.setTitle("Start", forState: .Normal)
            viewWithToggles.hidden = false
        }else if(ballPosition.1==GridView3.rows-1){
            timer.invalidate()
            p2Score+=1
            whoWon.text = "Player 1: \(p1Score)      Player 2: \(p2Score)"
            startButton.setTitle("Start", forState: .Normal)
            viewWithToggles.hidden = false
        }
        if(p1Score==10){
            whoWon.text = "Player 1 Wins!"
        }else if(p2Score==10){
            whoWon.text = "Player 2 Wins!"
        }
        if timer.valid{
            GridView3.grid[ballPosition.1,ballPosition.0] = .Empty
            prevPos.0=ballPosition.0
            prevPos.1=ballPosition.1
            ballPosition.0 += bp0
            ballPosition.1 += bp1
            GridView3.grid[ballPosition.1,ballPosition.0] = .Living
            GridView3.setNeedsDisplayInRect(CGRect(x: cellWidth*CGFloat(ballPosition.0), y: cellHeight*CGFloat(ballPosition.1), width: cellWidth, height: cellHeight))
            GridView3.setNeedsDisplayInRect(CGRect(x: cellWidth*(CGFloat(prevPos.0)), y: cellHeight*(CGFloat(prevPos.1)), width: cellWidth, height: cellHeight))
        }
        if(OneOrTwoLabel.text=="1 Player Mode"){
            moveAI(justDid)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        p1Size.maximumValue = Float(GridView3.rows-12)
        p2Size.maximumValue = Float(GridView3.rows-12)
        cellHeight=(GridView3.bounds.height/CGFloat(GridView3.rows))
        cellWidth=(GridView3.bounds.width/CGFloat(GridView3.cols))
        resetPaddles()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
