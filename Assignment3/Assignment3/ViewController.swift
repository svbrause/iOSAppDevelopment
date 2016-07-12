//
//  ViewController.swift
//  Assignment3
//
//  Created by Sam Brause on 7/7/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import UIKit
enum CellState: String{
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    var description: String{
        switch true{
        default:
            return self.rawValue
        }
    }
    
    static let allValues = [Living, Empty, Born, Died]
    
    func toggle(value: CellState) -> CellState {
        if (value == .Empty || value == .Died) {
            return .Living
        }else{
            return .Empty
        }
    }
}

class ViewController: UIViewController {
    @IBAction func ButtonPressed2(sender: AnyObject) {
        GridView3.grid = Array(count: GridView3.cols+1, repeatedValue: Array(count: GridView3.rows+1, repeatedValue: CellState.Empty))
        for a in 0..<GridView3.cols{
            for b in 0..<GridView3.rows{
                if arc4random_uniform(3) == 1 {
                    GridView3.grid[a][b] = .Living
                }
            }
        }
        GridView3.setNeedsDisplay()
    }
    @IBOutlet weak var GridView3: GridView!
    
    @IBAction func Iterate(sender: AnyObject) {
        
        for a in 0..<GridView3.cols{
            for b in 0..<GridView3.rows{
                if(GridView3.grid[a][b] == .Born){
                    GridView3.grid[a][b] = .Living
                }else if(GridView3.grid[a][b] == .Died){
                    GridView3.grid[a][b] = .Empty
                }
            }
        }
        var neighbors = Array(count: GridView3.cols+1, repeatedValue: Array(count: GridView3.rows+1, repeatedValue: 0))
        for a in 0..<GridView3.cols{
            for b in 0..<GridView3.rows{
                switch true{
                    //Middle section of the grid
                case (a>0&&b>0&&a<GridView3.cols-1&&b<GridView3.rows-1):
                    if(GridView3.grid[a+1][b-1] == .Living||GridView3.grid[a+1][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b-1] == .Living||GridView3.grid[a-1][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b-1] == .Living||GridView3.grid[a][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b+1] == .Living||GridView3.grid[a-1][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b+1] == .Living||GridView3.grid[a][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b] == .Living||GridView3.grid[a+1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b] == .Living||GridView3.grid[a-1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b+1] == .Living||GridView3.grid[a+1][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                //Top row of the grid
                case (a==0&&b>0&&b<GridView3.rows-1):
                    if(GridView3.grid[a+1][b+1] == .Living||GridView3.grid[a+1][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+GridView3.cols-1][b+1] == .Living||GridView3.grid[a+GridView3.cols-1][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b+1] == .Living||GridView3.grid[a][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b-1] == .Living||GridView3.grid[a+1][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+GridView3.cols-1][b-1] == .Living||GridView3.grid[a+GridView3.cols-1][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b-1] == .Living||GridView3.grid[a][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b] == .Living||GridView3.grid[a+1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+GridView3.cols-1][b] == .Living||GridView3.grid[a+GridView3.cols-1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                //Top right corner of the grid
                case (a==0&&b==GridView3.rows-1):
                    if(GridView3.grid[a+1][0] == .Living||GridView3.grid[a+1][0] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+GridView3.cols-1][0] == .Living||GridView3.grid[a+GridView3.cols-1][0] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][0] == .Living||GridView3.grid[a][0] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b-1] == .Living||GridView3.grid[a+1][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+GridView3.cols-1][b-1] == .Living||GridView3.grid[a+GridView3.cols-1][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b-1] == .Living||GridView3.grid[a][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b] == .Living||GridView3.grid[a+1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+GridView3.cols-1][b] == .Living||GridView3.grid[a+GridView3.cols-1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                //Bottom left corner of the grid
                case (b==0&&a==GridView3.cols-1):
                    if(GridView3.grid[0][b+1] == .Living||GridView3.grid[0][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[0][b+GridView3.rows-1] == .Living||GridView3.grid[0][b+GridView3.rows-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[0][b] == .Living||GridView3.grid[0][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b+1] == .Living||GridView3.grid[a-1][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b+GridView3.rows-1] == .Living||GridView3.grid[a-1][b+GridView3.rows-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b+GridView3.rows-1] == .Living||GridView3.grid[a][b+GridView3.rows-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b+1] == .Living||GridView3.grid[a][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b] == .Living||GridView3.grid[a-1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                
                //Far left column of the grid
                case (b==0&&a>0&&a<GridView3.cols-1):
                    if(GridView3.grid[a+1][b+1] == .Living||GridView3.grid[a+1][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b+GridView3.rows-1] == .Living||GridView3.grid[a+1][b+GridView3.rows-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b] == .Living||GridView3.grid[a+1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b+1] == .Living||GridView3.grid[a-1][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b+GridView3.rows-1] == .Living||GridView3.grid[a-1][b+GridView3.rows-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b+GridView3.rows-1] == .Living||GridView3.grid[a][b+GridView3.rows-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b+1] == .Living||GridView3.grid[a][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b] == .Living||GridView3.grid[a-1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                //Bottom row of grid
                case (a==GridView3.cols-1&&b>0&&b<GridView3.rows-1):
                    if(GridView3.grid[a-1][b-1] == .Living||GridView3.grid[a-1][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b] == .Living||GridView3.grid[a-1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b+1] == .Living||GridView3.grid[a-1][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b+1] == .Living||GridView3.grid[a][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b-1] == .Living||GridView3.grid[a][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[0][b-1] == .Living||GridView3.grid[0][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[0][b+1] == .Living||GridView3.grid[0][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[0][b] == .Living||GridView3.grid[0][b] == .Born){
                        neighbors[a][b] += 1
                    }
                //Rightmost column of the grid
                case (b==GridView3.rows-1&&a>0&&a<GridView3.cols-1):
                    if(GridView3.grid[a+1][b-1] == .Living||GridView3.grid[a+1][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][0] == .Living||GridView3.grid[a+1][0] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b] == .Living||GridView3.grid[a+1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b-1] == .Living||GridView3.grid[a-1][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][0] == .Living||GridView3.grid[a-1][0] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][0] == .Living||GridView3.grid[a][0] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b-1] == .Living||GridView3.grid[a][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b] == .Living||GridView3.grid[a-1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                //Top left corner of the grid
                case (b==0&&a==0):
                    if(GridView3.grid[a+1][b+1] == .Living||GridView3.grid[a+1][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+GridView3.cols-1][b+1] == .Living||GridView3.grid[a+GridView3.cols-1][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b+GridView3.rows-1] == .Living||GridView3.grid[a+1][b+GridView3.rows-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+GridView3.cols-1][b+GridView3.rows-1] == .Living||GridView3.grid[a+GridView3.cols-1][b+GridView3.rows-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b+GridView3.rows-1] == .Living||GridView3.grid[a][b+GridView3.rows-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b+1] == .Living||GridView3.grid[a][b+1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+1][b] == .Living||GridView3.grid[a+1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a+GridView3.cols-1][b] == .Living||GridView3.grid[a+GridView3.cols-1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    //Bottom right corner of the grid
                case (b==GridView3.rows-1&&a==GridView3.cols-1):
                    if(GridView3.grid[0][0] == .Living||GridView3.grid[0][0] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][0] == .Living||GridView3.grid[a-1][0] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[0][b-1] == .Living||GridView3.grid[0][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b-1] == .Living||GridView3.grid[a-1][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][b-1] == .Living||GridView3.grid[a][b-1] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a][0] == .Living||GridView3.grid[a][0] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[0][b] == .Living||GridView3.grid[0][b] == .Born){
                        neighbors[a][b] += 1
                    }
                    if(GridView3.grid[a-1][b] == .Living||GridView3.grid[a-1][b] == .Born){
                        neighbors[a][b] += 1
                    }
                default:
                    break
                }
            }
        }
        for a in 0..<GridView3.cols{
            for b in 0..<GridView3.rows{
                if(GridView3.grid[a][b] == .Living){
                    if(neighbors[a][b]<2){
                        GridView3.grid[a][b] = .Died
                    }else if(neighbors[a][b]>1&&neighbors[a][b]<4){
                        GridView3.grid[a][b] = .Living
                    }else if(neighbors[a][b]>3){
                        GridView3.grid[a][b] = .Died
                    }
                }else{
                    if(neighbors[a][b]==3){
                        GridView3.grid[a][b] = .Born
                    }else{
                        GridView3.grid[a][b] = .Empty
                    }
                }
            }
        }
        
        GridView3.setNeedsDisplay()
    }
    @IBAction func ButtonPressed(sender: AnyObject) {
        for a in 0..<GridView3.cols{
            for b in 0..<GridView3.rows{
                GridView3.grid[a][b] = GridView3.grid[a][b].toggle(GridView3.grid[a][b])
            }
        }
        GridView3.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

