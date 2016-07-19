//
//  Engine.swift
//  Assignment4
//
//  Created by Sam Brause on 7/15/16.
//  Copyright © 2016 Sam Brause. All rights reserved.
//

import Foundation

protocol EngineProtocol{
    var delegate: EngineDelegate? {get }
    var grid: GridProtocol{ get }
    var refreshRate: Double{get set}
    var refreshTimer: NSTimer?{get set}
    init(rows: Int, cols: Int)
    var rows: Int{get set}
    var cols: Int{get set}
    func step(grid4: Array<Array<CellState>>) -> Array<Array<CellState>>
}

protocol EngineDelegate{
    func engineDidUpdate(withGrid: StandardEngine, GridProtocol: NSObjectProtocol)
}

class StandardEngine: EngineProtocol{
    
    var timeInterval = 0.2
    
    func countCells() -> Array<Int> {
        var cellStates = Array(count: 4, repeatedValue:0)
        for a in 0..<cols{
            for b in 0..<rows{
                if(grid2[a][b] == .Living){
                    cellStates[0] += 1
                }else if(grid2[a][b] == .Born){
                    cellStates[1] += 1
                }else if(grid2[a][b] == .Died){
                    cellStates[2] += 1
                }else if(grid2[a][b] == .Empty){
                    cellStates[3] += 1
                }
            }
        }
        return cellStates
    }
    
    func initialize() -> Array<Array<CellState>> {
        for a in 0..<cols{
            for b in 0..<rows{
                grid2[a][b] = .Empty
            }
        }
        for a in 0..<cols{
            for b in 0..<rows{
                if arc4random_uniform(3) == 1 {
                    grid2[a][b] = .Living
                }
            }
        }
        return grid2
    }
    
    private static var _sharedInstance = StandardEngine(rows: 10, cols: 10)
    static var sharedInstance: StandardEngine {
            return _sharedInstance
    }
    
    var grid: GridProtocol{
        get{
            return self.grid
        }
    }
    
    var delegate: EngineDelegate?
    
    var grid2 = Array(count: 011340, repeatedValue: Array(count: 011340, repeatedValue: CellState.Empty))
    
    var refreshRate: Double{
        get{
            return 0.0
        }
        set(newValue){
            self.refreshRate = newValue
        }
    }
    
    var refreshTimer: NSTimer?
    required init(rows: Int, cols: Int){
        self.rows = rows
        self.cols = cols
    }
    
    var rows: Int{
        didSet{
            if let delegate = delegate {
                delegate.engineDidUpdate(self, GridProtocol: self.rows)
            }
        }
    }
    var cols: Int{
        didSet{
            if let delegate = delegate {
                delegate.engineDidUpdate(self, GridProtocol: self.cols)
            }
        }
    }
    func step(grid4: Array<Array<CellState>>) -> Array<Array<CellState>>{
        var grid3 = grid4
        for a in 0..<cols{
            for b in 0..<rows{
                if(grid3[a][b] == .Born){
                    grid3[a][b] = .Living
                }else if(grid3[a][b] == .Died){
                    grid3[a][b] = .Empty
                }
            }
        }
        var neighborCells = Array(count: cols, repeatedValue: Array(count: rows, repeatedValue: Array(count: 8, repeatedValue: (0,0))))
        var numNeighbors = Array(count: cols, repeatedValue: Array(count: rows, repeatedValue: 0))
        for a in 0..<cols{
            for b in  0..<rows{
                neighborCells[a][b] = Grid.sharedInstance.neighbors((a,b))
                for i in 0...7{
                    if grid3[neighborCells[a][b][i].0][neighborCells[a][b][i].1] == .Living || grid3[neighborCells[a][b][i].0][neighborCells[a][b][i].1] == .Born {
                        numNeighbors[a][b] += 1
                    }
                }
            }
        }
        for a in 0..<cols{
            for b in 0..<rows{
                if(grid3[a][b] == .Living){
                    if(numNeighbors[a][b]<2){
                        grid3[a][b] = .Died
                    }else if(numNeighbors[a][b]>1&&numNeighbors[a][b]<4){
                        grid3[a][b] = .Living
                    }else if(numNeighbors[a][b]>3){
                        grid3[a][b] = .Died
                    }
                }else{
                    if(numNeighbors[a][b]==3){
                        grid3[a][b] = .Born
                    }else{
                        grid3[a][b] = .Empty
                    }
                }
            }
        }
        return grid3
    }
}
